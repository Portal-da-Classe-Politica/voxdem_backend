import re

# Ler o arquivo
with open('sqlinserts/voxdem_data_common_tables_insert.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Mapa completo de correções
replacements = {
    # Letras acentuadas
    'Ã¡': 'á', 'Ã©': 'é', 'Ã­': 'í', 'Ã³': 'ó', 'Ãº': 'ú',
    'Ã ': 'à', 'Ã¨': 'è', 'Ã¬': 'ì', 'Ã²': 'ò', 'Ã¹': 'ù',
    'Ã¢': 'â', 'Ãª': 'ê', 'Ã®': 'î', 'Ã´': 'ô', 'Ã»': 'û',
    'Ã£': 'ã', 'Ãµ': 'õ',
    'Ã§': 'ç',
    
    # Maiúsculas
    'Ã\x81': 'Á', 'Ã‰': 'É', 'Ã\x8d': 'Í', 'Ã"': 'Ó', 
    'Ã€': 'À', 'Ã\x88': 'È', 
    'Ã‚': 'Â', 'ÃŠ': 'Ê', 'Ã"': 'Ô', 
    'Ãƒ': 'Ã', 'Ã•': 'Õ',
    'Ã‡': 'Ç',
    
    # Combinações específicas encontradas
    'Ã©': 'é',
    'NÃ­vel': 'Nível',
    'Ã‰': 'É',
}

# Aplicar todas as correções
for wrong, correct in replacements.items():
    content = content.replace(wrong, correct)

# Salvar com codificação UTF-8
with open('sqlinserts/voxdem_data_common_tables_insert.sql', 'w', encoding='utf-8') as f:
    f.write(content)

# Verificar se ainda há problemas
problematic_lines = []
for i, line in enumerate(content.split('\n'), 1):
    if re.search(r'Ã|Â', line):
        problematic_lines.append((i, line[:100]))

print(f"Codificação corrigida!")
print(f"Linhas com possíveis problemas restantes: {len(problematic_lines)}")

if problematic_lines:
    print("\nPrimeiras 10 linhas com problemas:")
    for num, line in problematic_lines[:10]:
        print(f"{num}: {line}")
else:
    print("\nTodas as linhas foram corrigidas com sucesso!")
