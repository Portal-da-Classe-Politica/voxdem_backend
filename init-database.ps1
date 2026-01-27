# =====================================================
# VoxDem Database Initialization Script (PowerShell)
# =====================================================
# Usage: .\init-database.ps1 [-Host localhost] [-Port 5433] [-Database voxdem_survey] [-User postgres]
# =====================================================

param(
    [string]$Host = "localhost",
    [int]$Port = 5433,
    [string]$Database = "voxdem_survey",
    [string]$User = "postgres",
    [switch]$DropExisting,
    [switch]$Force
)

Write-Host "==========================================="
Write-Host "VoxDem Database Initialization"
Write-Host "==========================================="
Write-Host ""

# Set environment variable for password prompt
$env:PGPASSWORD = "postgres"

# Connection string
$connString = "host=$Host port=$Port dbname=$Database user=$User"

Write-Host "Connection Details:"
Write-Host "  Host: $Host"
Write-Host "  Port: $Port"
Write-Host "  Database: $Database"
Write-Host "  User: $User"
Write-Host ""

# Check if PostgreSQL is available
Write-Host "Checking PostgreSQL connection..."
$testConnection = & pg_isready -h $Host -p $Port -U $User 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Cannot connect to PostgreSQL server" -ForegroundColor Red
    Write-Host $testConnection
    exit 1
}

Write-Host "✓ PostgreSQL connection successful" -ForegroundColor Green
Write-Host ""

# Check if database exists
Write-Host "Checking if database exists..."
$dbExists = & psql -h $Host -p $Port -U $User -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$Database';" 2>&1

if ($dbExists -eq "1") {
    Write-Host "✓ Database '$Database' exists" -ForegroundColor Yellow
    
    if ($DropExisting) {
        if (-not $Force) {
            $confirmation = Read-Host "Are you sure you want to DROP and recreate the database? (yes/no)"
            if ($confirmation -ne "yes") {
                Write-Host "Operation cancelled." -ForegroundColor Yellow
                exit 0
            }
        }
        
        Write-Host ""
        Write-Host "Dropping existing database..." -ForegroundColor Yellow
        
        # Terminate existing connections
        & psql -h $Host -p $Port -U $User -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='$Database' AND pid <> pg_backend_pid();" | Out-Null
        
        # Drop database
        & psql -h $Host -p $Port -U $User -d postgres -c "DROP DATABASE IF EXISTS $Database;" | Out-Null
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "ERROR: Failed to drop database" -ForegroundColor Red
            exit 1
        }
        
        Write-Host "✓ Database dropped" -ForegroundColor Green
        Write-Host ""
        
        # Create database
        Write-Host "Creating database..."
        & psql -h $Host -p $Port -U $User -d postgres -c "CREATE DATABASE $Database WITH ENCODING='UTF8';" | Out-Null
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "ERROR: Failed to create database" -ForegroundColor Red
            exit 1
        }
        
        Write-Host "✓ Database created" -ForegroundColor Green
    }
    else {
        # Check if tables exist
        $tableCount = & psql -h $Host -p $Port -U $User -d $Database -tAc "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';" 2>&1
        
        if ([int]$tableCount -gt 0) {
            Write-Host ""
            Write-Host "WARNING: Database already contains $tableCount tables" -ForegroundColor Yellow
            Write-Host "Use -DropExisting flag to drop and recreate the database" -ForegroundColor Yellow
            
            if (-not $Force) {
                $confirmation = Read-Host "Continue anyway? (yes/no)"
                if ($confirmation -ne "yes") {
                    Write-Host "Operation cancelled." -ForegroundColor Yellow
                    exit 0
                }
            }
        }
    }
}
else {
    Write-Host "Database does not exist. Creating..." -ForegroundColor Yellow
    & psql -h $Host -p $Port -U $User -d postgres -c "CREATE DATABASE $Database WITH ENCODING='UTF8';" | Out-Null
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to create database" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "✓ Database created" -ForegroundColor Green
}

Write-Host ""
Write-Host "==========================================="
Write-Host "Starting Data Import"
Write-Host "==========================================="
Write-Host ""

# Run initialization script
Write-Host "Executing initialization script..."
Write-Host ""

$startTime = Get-Date

& psql -h $Host -p $Port -U $User -d $Database -f "init-database.sql"

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Database initialization failed" -ForegroundColor Red
    exit 1
}

$endTime = Get-Date
$duration = $endTime - $startTime

Write-Host ""
Write-Host "==========================================="
Write-Host "Database Initialization Complete!" -ForegroundColor Green
Write-Host "==========================================="
Write-Host ""
Write-Host "Time elapsed: $($duration.ToString('mm\:ss'))"
Write-Host ""
Write-Host "You can now start the application with: npm run dev"
