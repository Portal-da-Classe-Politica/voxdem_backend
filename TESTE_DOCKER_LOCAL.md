# 🐳 Guia de Teste Docker Local - VoxDem Backend

## 🚀 Teste Rápido (Método Recomendado)

### 1. Preparar ambiente limpo
```powershell
# Windows PowerShell
docker-compose down -v
docker system prune -f
```

### 2. Iniciar apenas PostgreSQL
```powershell
# Iniciar PostgreSQL
docker-compose up -d postgres

# Aguardar inicialização (pode demorar devido ao dump de 69MB)
Start-Sleep 60

# Verificar status
docker ps
```

### 3. Verificar se funcionou
```powershell
# Verificar logs
docker-compose logs postgres | Select-Object -Last 20

# Testar conexão
docker exec -it survey_postgres psql -U postgres -d voxdem_survey -c "SELECT version();"

# Verificar tabelas
docker exec -it survey_postgres psql -U postgres -d voxdem_survey -c "SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public';"

# Verificar dados
docker exec -it survey_postgres psql -U postgres -d voxdem_survey -c "SELECT count(*) FROM response_analysis;"
```

### 4. Iniciar aplicação completa
```powershell
# Se o banco funcionou, iniciar tudo
docker-compose up -d

# Verificar todos os containers
docker-compose ps

# Testar API
curl http://localhost:3000/health
```

## 🛠️ Método Alternativo (Se houver problemas)

### Opção A: Aplicar dump manualmente
```powershell
# 1. Iniciar apenas PostgreSQL sem dump
# Editar docker-compose.yml - remover linha do dump temporariamente

# 2. Aplicar dump manualmente
docker exec -i survey_postgres psql -U postgres -d voxdem_survey < voxdem_survey_dump_clean.sql

# 3. Verificar dados
docker exec survey_postgres psql -U postgres -d voxdem_survey -c "SELECT count(*) FROM response_analysis;"
```

### Opção B: Usar script PowerShell
```powershell
# Criar script PowerShell para aplicar dump
$dumpContent = Get-Content "voxdem_survey_dump.sql" | Where-Object { $_ -notmatch "CREATE DATABASE" }
$dumpContent | docker exec -i survey_postgres psql -U postgres -d voxdem_survey
```

### Opção C: Carregar dados via aplicação
```powershell
# 1. Iniciar sem dump
docker-compose up -d postgres

# 2. Executar script de inicialização via aplicação
# (Se a aplicação tiver seed data ou migration)
npm run migrate
npm run seed
```

## 🔍 Comandos de Verificação

### Status dos containers
```powershell
docker-compose ps
docker ps -a
```

### Logs detalhados
```powershell
# Logs do PostgreSQL
docker-compose logs postgres

# Logs da aplicação
docker-compose logs app

# Logs em tempo real
docker-compose logs -f
```

### Conexão direta ao banco
```powershell
# Conectar ao PostgreSQL
docker exec -it survey_postgres psql -U postgres -d voxdem_survey

# Dentro do psql:
\dt          # Listar tabelas
\d response_analysis  # Descrever tabela
SELECT count(*) FROM response_analysis LIMIT 5;
```

### Verificar estrutura do banco
```sql
-- Quantas tabelas foram criadas
SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public';

-- Listar todas as tabelas
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' ORDER BY table_name;

-- Verificar dados principais
SELECT 
    'response_analysis' as table_name, 
    count(*) as row_count 
FROM response_analysis
UNION ALL
SELECT 
    'activity_sectors' as table_name, 
    count(*) as row_count 
FROM activity_sectors
UNION ALL
SELECT 
    'education_levels' as table_name, 
    count(*) as row_count 
FROM education_levels;
```

## 🚨 Troubleshooting

### Container não inicia
```powershell
# Verificar logs de erro
docker logs survey_postgres

# Verificar se porta está em uso
netstat -an | findstr 5433

# Limpar tudo e recomeçar
docker-compose down -v
docker system prune -f
docker volume prune -f
```

### Dump muito lento
```powershell
# O dump tem 69MB, pode demorar. Verificar progresso:
docker logs survey_postgres -f

# Se travar, pode usar versão menor:
# Criar dump apenas com estrutura (sem dados)
pg_dump --schema-only -h localhost -U postgres voxdem_survey > schema_only.sql
```

### Erro de sequências
```powershell
# Aplicar sequências manualmente
docker exec -i survey_postgres psql -U postgres -d voxdem_survey < init-database.sql
```

### Problema de encoding
```powershell
# Verificar encoding do dump
file voxdem_survey_dump.sql

# Converter se necessário
iconv -f iso-8859-1 -t utf-8 voxdem_survey_dump.sql > voxdem_survey_dump_utf8.sql
```

## ⚡ Comandos Rápidos

```powershell
# Restart completo
docker-compose down -v && docker-compose up -d && Start-Sleep 60 && docker exec survey_postgres psql -U postgres -d voxdem_survey -c "SELECT count(*) FROM response_analysis;"

# Verificação rápida
docker ps && docker exec survey_postgres psql -U postgres -d voxdem_survey -c "SELECT version();"

# Logs rápidos
docker-compose logs postgres | Select-Object -Last 10

# Cleanup rápido
docker-compose down -v && docker system prune -f
```

## 📊 Resultados Esperados

Se tudo funcionar corretamente, você deve ver:

- ✅ Container PostgreSQL rodando na porta 5433
- ✅ Banco `voxdem_survey` criado
- ✅ Aproximadamente 20+ tabelas criadas
- ✅ Dados carregados (response_analysis com milhares de registros)
- ✅ Aplicação rodando na porta 3000
- ✅ API respondendo em http://localhost:3000

## 🎯 Próximos Passos

Após o teste local funcionar:
1. Testar endpoints da API
2. Verificar análises de dados
3. Testar cross-tabulation
4. Preparar para deploy em produção
