# 📊 VoxDem Survey - Como Recuperar o Dump

O arquivo `voxdem_survey_dump.sql` contém todos os dados da pesquisa VoxDem. Este guia explica como aplicá-lo em diferentes cenários.

## 🐳 Método 1: Docker (Automático)

### Para desenvolvimento local:
```bash
# O dump será carregado automaticamente
docker-compose up -d postgres

# Verificar se carregou
docker-compose logs postgres
```

### Para aplicar apenas o dump em container existente:
```bash
# Copiar dump para o container
docker cp voxdem_survey_dump.sql survey_postgres:/tmp/

# Executar dentro do container
docker exec -i survey_postgres psql -U postgres -d voxdem_survey < /tmp/voxdem_survey_dump.sql
```

## 🖥️ Método 2: Servidor Local/Remoto

### Linux/Mac:
```bash
# Método 1: Script automático
chmod +x apply-dump.sh
./apply-dump.sh

# Método 2: Manual
# Criar banco (se não existir)
createdb voxdem_survey

# Aplicar dump (removendo CREATE DATABASE)
sed '/CREATE DATABASE voxdem_survey/d' voxdem_survey_dump.sql | psql -d voxdem_survey
```

### Windows:
```cmd
# Método 1: Script automático
apply-dump.bat

# Método 2: Manual com PowerShell
createdb voxdem_survey
powershell -Command "(Get-Content 'voxdem_survey_dump.sql') | Where-Object { $_ -notmatch 'CREATE DATABASE voxdem_survey' } | psql -d voxdem_survey"
```

## 🌐 Método 3: Servidor Remoto

### Conectar a servidor específico:
```bash
# Linux/Mac
sed '/CREATE DATABASE voxdem_survey/d' voxdem_survey_dump.sql | psql -h SEU_HOST -p 5432 -U SEU_USUARIO -d voxdem_survey

# Windows
powershell -Command "(Get-Content 'voxdem_survey_dump.sql') | Where-Object { $_ -notmatch 'CREATE DATABASE voxdem_survey' } | psql -h SEU_HOST -p 5432 -U SEU_USUARIO -d voxdem_survey"
```

### Para AWS RDS, Azure, Google Cloud:
```bash
# Substituir pelos dados do seu provider
psql -h your-rds-instance.amazonaws.com -p 5432 -U voxdem_user -d voxdem_survey -f voxdem_survey_dump_clean.sql
```

## ⚙️ Método 4: Usando pgAdmin ou DBeaver

1. **Criar conexão** com seu banco PostgreSQL
2. **Criar banco** `voxdem_survey` (se não existir)
3. **Editar o dump**:
   - Abrir `voxdem_survey_dump.sql` em editor de texto
   - Remover ou comentar a linha: `CREATE DATABASE voxdem_survey WITH TEMPLATE = template0 ENCODING = 'UTF8';`
   - Remover ou comentar a linha: `\c voxdem_survey;`
4. **Executar script** no banco `voxdem_survey`

## 🔍 Verificação

Após aplicar o dump, verificar se os dados foram carregados:

```sql
-- Verificar tabelas criadas
SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public';

-- Verificar dados principais
SELECT count(*) FROM response_analysis;
SELECT count(*) FROM activity_sectors;
SELECT count(*) FROM education_levels;

-- Verificar uma amostra de dados
SELECT * FROM response_analysis LIMIT 5;
```

## 🆘 Problemas Comuns

### Erro: "database already exists"
```bash
# Remover linha CREATE DATABASE do dump
sed -i '/CREATE DATABASE voxdem_survey/d' voxdem_survey_dump.sql
```

### Erro: "relation does not exist"
```bash
# Executar primeiro o script de sequências
psql -d voxdem_survey -f init-database.sql
# Depois aplicar o dump
```

### Erro: "permission denied"
```sql
-- Verificar permissões
\du
-- Dar permissões ao usuário
GRANT ALL PRIVILEGES ON DATABASE voxdem_survey TO seu_usuario;
```

### Erro: "encoding mismatch"
```bash
# Converter encoding se necessário
iconv -f latin1 -t utf8 voxdem_survey_dump.sql > voxdem_survey_dump_utf8.sql
```

## 📈 Estrutura dos Dados

O dump contém as seguintes tabelas principais:

- **response_analysis**: Respostas da pesquisa (tabela principal)
- **activity_sectors**: Setores de atividade
- **education_levels**: Níveis de educação
- **income_ranges**: Faixas de renda
- **age_ranges**: Faixas etárias
- **marital_statuses**: Estados civis
- **parties**: Partidos políticos
- **regions**: Regiões geográficas
- **states**: Estados
- **cities**: Cidades

## 💡 Dicas

1. **Backup**: Sempre faça backup antes de aplicar o dump
2. **Teste**: Teste primeiro em ambiente de desenvolvimento
3. **Monitoring**: Monitore o uso de espaço em disco
4. **Performance**: Para grandes volumes, considere usar `pg_restore` com paralelização
5. **Compressão**: O dump pode ser comprimido para economizar espaço

## 📞 Suporte

Se encontrar problemas:
1. Verificar logs do PostgreSQL
2. Verificar permissões de usuário
3. Verificar espaço em disco
4. Consultar documentação do PostgreSQL
5. Abrir issue no repositório
