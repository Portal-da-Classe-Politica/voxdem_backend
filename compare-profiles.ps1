param(
    [string]$VoxdePath = "sqlinserts/voxde_data_profiles_insert.sql",
    [string]$OriginalPath = "sqlinserts/voxdem_original_profiles.sql",
    [string]$OutPath = "compare-profiles-divergences.csv",
    [string]$MissingOutPath = "compare-profiles-missing.csv"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-ProjectPath {
    param([string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return (Join-Path -Path $PSScriptRoot -ChildPath $Path)
}

function Split-SqlValues {
    param([string]$ValueText)

    $values = New-Object System.Collections.Generic.List[string]
    $current = New-Object System.Text.StringBuilder
    $inString = $false
    $i = 0

    while ($i -lt $ValueText.Length) {
        $ch = $ValueText[$i]

        if ($ch -eq "'") {
            if ($inString -and $i + 1 -lt $ValueText.Length -and $ValueText[$i + 1] -eq "'") {
                [void]$current.Append("'")
                $i += 2
                continue
            }
            $inString = -not $inString
            $i++
            continue
        }

        if (-not $inString -and $ch -eq ',') {
            $values.Add($current.ToString().Trim())
            $current.Clear() | Out-Null
            $i++
            continue
        }

        [void]$current.Append($ch)
        $i++
    }

    $values.Add($current.ToString().Trim())

    return $values
}

function Normalize-Value {
    param($Value)

    if ($null -eq $Value) {
        return $null
    }

    $text = $Value.ToString().Trim()

    if ($text -eq "") {
        return ""
    }

    return $text
}

function Parse-InsertFile {
    param([string]$Path)

    $content = Get-Content -Path $Path -Raw -Encoding UTF8

    $headerMatch = [regex]::Match(
        $content,
        "INSERT\s+INTO\s+public\.profiles\s*\((.*?)\)\s*VALUES",
        [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    if (-not $headerMatch.Success) {
        throw "Não foi possível localizar o cabeçalho INSERT em $Path"
    }

    $columns = $headerMatch.Groups[1].Value.Split(',') | ForEach-Object { $_.Trim() }
    $valuesStart = $content.IndexOf("VALUES", [System.StringComparison]::OrdinalIgnoreCase)

    if ($valuesStart -lt 0) {
        throw "Não foi possível localizar a seção VALUES em $Path"
    }

    $valuesSection = $content.Substring($valuesStart + 6)

    $rows = @{}
    $inString = $false
    $depth = 0
    $tupleStart = -1

    for ($i = 0; $i -lt $valuesSection.Length; $i++) {
        $ch = $valuesSection[$i]

        if ($ch -eq "'") {
            if ($inString -and $i + 1 -lt $valuesSection.Length -and $valuesSection[$i + 1] -eq "'") {
                $i++
                continue
            }
            $inString = -not $inString
            continue
        }

        if (-not $inString) {
            if ($ch -eq '(') {
                if ($depth -eq 0) {
                    $tupleStart = $i + 1
                }
                $depth++
            } elseif ($ch -eq ')') {
                $depth--
                if ($depth -eq 0 -and $tupleStart -ge 0) {
                    $tupleText = $valuesSection.Substring($tupleStart, $i - $tupleStart)
                    $values = Split-SqlValues -ValueText $tupleText

                    if ($values.Count -ne $columns.Count) {
                        throw "Quantidade de colunas divergente no INSERT ($($values.Count) vs $($columns.Count))"
                    }

                    $row = @{}
                    for ($c = 0; $c -lt $columns.Count; $c++) {
                        $raw = $values[$c]
                        if ($raw -eq "NULL") {
                            $row[$columns[$c]] = $null
                        } else {
                            $row[$columns[$c]] = $raw
                        }
                    }

                    if ($row.ContainsKey("id")) {
                        $rows[$row["id"]] = $row
                    }

                    $tupleStart = -1
                }
            }
        }
    }

    return [pscustomobject]@{
        Columns = $columns
        Rows = $rows
    }
}

function Parse-CopyFile {
    param([string]$Path)

    $lines = Get-Content -Path $Path -Encoding UTF8
    $headerIndex = -1
    $columns = $null

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        if ($line -match "^COPY\s+public\.profiles\s*\((.*?)\)\s*FROM\s+stdin;") {
            $headerIndex = $i
            $columns = $Matches[1].Split(',') | ForEach-Object { $_.Trim() }
            break
        }
    }

    if ($headerIndex -lt 0) {
        throw "Não foi possível localizar o cabeçalho COPY em $Path"
    }

    $rows = @{}

    for ($i = $headerIndex + 1; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        if ($line -eq "\\.") {
            break
        }

        if ([string]::IsNullOrWhiteSpace($line)) {
            continue
        }

        $parts = $line.Split("`t")

        if ($parts.Count -ne $columns.Count) {
            throw "Quantidade de colunas divergente no COPY ($($parts.Count) vs $($columns.Count))"
        }

        $row = @{}
        for ($c = 0; $c -lt $columns.Count; $c++) {
            $raw = $parts[$c]
            if ($raw -eq "\\N") {
                $row[$columns[$c]] = $null
            } else {
                $row[$columns[$c]] = $raw
            }
        }

        if ($row.ContainsKey("id")) {
            $rows[$row["id"]] = $row
        }
    }

    return [pscustomobject]@{
        Columns = $columns
        Rows = $rows
    }
}

$voxdeFull = Resolve-ProjectPath -Path $VoxdePath
$originalFull = Resolve-ProjectPath -Path $OriginalPath
$outFull = Resolve-ProjectPath -Path $OutPath
$missingFull = Resolve-ProjectPath -Path $MissingOutPath

$insertData = Parse-InsertFile -Path $voxdeFull
$copyData = Parse-CopyFile -Path $originalFull

$sharedColumns = $insertData.Columns | Where-Object {
    $_ -in $copyData.Columns -and $_ -notin @("created_at", "updated_at", "survey_id")
}

$insertIds = [System.Collections.Generic.HashSet[string]]::new()
$copyIds = [System.Collections.Generic.HashSet[string]]::new()

foreach ($key in $insertData.Rows.Keys) {
    $insertIds.Add($key) | Out-Null
}

foreach ($key in $copyData.Rows.Keys) {
    $copyIds.Add($key) | Out-Null
}

$commonIds = $insertIds.Where({ $copyIds.Contains($_) })
$missingInInsert = $copyIds.Where({ -not $insertIds.Contains($_) })
$missingInOriginal = $insertIds.Where({ -not $copyIds.Contains($_) })

$divergences = New-Object System.Collections.Generic.List[object]

foreach ($id in $commonIds) {
    $left = $insertData.Rows[$id]
    $right = $copyData.Rows[$id]

    foreach ($column in $sharedColumns) {
        $leftValue = Normalize-Value $left[$column]
        $rightValue = Normalize-Value $right[$column]

        if ($leftValue -eq $rightValue) {
            continue
        }

        $divergences.Add([pscustomobject]@{
            id = $id
            column = $column
            voxde_value = $leftValue
            original_value = $rightValue
        })
    }
}

$divergences | Sort-Object id, column | Export-Csv -Path $outFull -NoTypeInformation -Encoding UTF8

$missing = @()
foreach ($id in $missingInInsert) {
    $missing += [pscustomobject]@{ id = $id; missing_in = "voxde_data_profiles_insert.sql" }
}
foreach ($id in $missingInOriginal) {
    $missing += [pscustomobject]@{ id = $id; missing_in = "voxdem_original_profiles.sql" }
}

if ($missing.Count -gt 0) {
    $missing | Sort-Object id, missing_in | Export-Csv -Path $missingFull -NoTypeInformation -Encoding UTF8
}

Write-Host "Comparação concluída."
Write-Host "Divergências: $($divergences.Count)" 
Write-Host "IDs faltando no INSERT: $($missingInInsert.Count)"
Write-Host "IDs faltando no ORIGINAL: $($missingInOriginal.Count)"
Write-Host "Arquivo de divergências: $outFull"
if ($missing.Count -gt 0) {
    Write-Host "Arquivo de faltantes: $missingFull"
}
