# VoxDem Survey API

API TypeScript para análise de dados de pesquisas eleitorais com tabulação cruzada de variáveis categóricas.

## Visão Geral

Esta API fornece endpoints para análise de dados de survey da base VoxDem, incluindo:

- Análise de perguntas por perfil demográfico
- Tabulação cruzada de variáveis categóricas
- Estatísticas descritivas e agregações
- Visualização de dados através de gráficos

## Stack Tecnológico

- **Runtime**: Node.js 18+
- **Linguagem**: TypeScript
- **Framework**: Express.js
- **ORM**: TypeORM
- **Banco de Dados**: PostgreSQL 15
- **Container**: Docker & Docker Compose

## Estrutura do Projeto

```
.
├── src/
│   ├── entities/          # Entidades TypeORM (Profile, Question, Answer, etc.)
│   ├── services/          # Lógica de negócio (AnalysisService)
│   ├── controllers/       # Controllers Express
│   ├── routes/            # Definição de rotas
│   ├── data/              # Dados estáticos (perguntas, rótulos)
│   ├── data-source.ts     # Configuração TypeORM
│   └── index.ts           # Entry point da aplicação
├── sqlinserts/            # Scripts SQL para carga de dados
│   ├── voxdem_schema.sql              # Schema do banco
│   ├── voxdem_data_common_tables.sql  # Tabelas de lookup
│   ├── voxdem_questions.sql           # Perguntas
│   ├── voxdem_answer_options.sql      # Opções de resposta
│   ├── voxde_data_profiles.sql        # Perfis
│   └── voxdem_data_responses.sql      # Respostas (~310k linhas)
├── database/              # Scripts de manutenção e diagnóstico
├── docker-compose.yml     # Configuração Docker
├── Dockerfile             # Imagem da aplicação
├── init-database.sql      # Script de inicialização do banco
├── init-database.ps1      # Inicialização local (PowerShell)
└── api-documentation.yaml # Documentação OpenAPI
```

## Quick Start

### Com Docker (Recomendado)

```bash
# 1. Clone o repositório
git clone <repo-url>
cd codigo

# 2. Inicie os containers (primeira vez pode levar ~3-5 minutos)
docker-compose up -d

# 3. Acompanhe os logs da inicialização
docker-compose logs -f postgres

# 4. A API estará disponível em http://localhost:3000
```

**Nota:** Na primeira inicialização, o PostgreSQL executará automaticamente:
- Criação do schema (voxdem_schema.sql)
- Carga de tabelas de lookup e referência
- Inserção de ~100 perguntas
- Inserção de ~1.5k perfis
- Inserção de ~310k respostas de survey

### Reiniciar do Zero

Se precisar recriar o banco de dados completamente:

```bash
# Windows PowerShell
.\reset-docker.ps1

# Linux/Mac
./reset-docker.sh

# Ou manualmente
docker-compose down -v
docker-compose up -d --build
```

### Local (Desenvolvimento)

#### Pré-requisitos

- Node.js 18+
- PostgreSQL 15+
- npm ou yarn

#### Passos

```bash
# 1. Instalar dependências
npm install

# 2. Configurar banco de dados
# Edite as variáveis no .env se necessário

# 3. Inicializar banco de dados
.\init-database.ps1

# 4. Compilar TypeScript
npm run build

# 5. Iniciar servidor de desenvolvimento
npm run dev
```

## Inicialização do Banco de Dados

O banco de dados é inicializado automaticamente usando o script [init-database.sql](init-database.sql), que executa os seguintes passos em ordem:

### Ordem de Execução

1. **Schema** (`voxdem_schema.sql`) - Criação de todas as tabelas, índices e constraints
2. **Tabelas Comuns** (`voxdem_data_common_tables_insert.sql`) - Dados de lookup (estados, regiões, etc.)
3. **Perguntas** - Carga das perguntas de ambas as pesquisas:
   - `voxdem_questions_insert.sql` - Perguntas da população geral
   - `deputados_questions_insert.sql` - Perguntas dos deputados
4. **Opções de Resposta** (`voxdem_answer_options_insert.sql`) - Todas as opções de resposta
5. **Perfis** - Perfis demográficos dos respondentes:
   - `voxde_data_profiles_insert.sql` - Perfis da população geral (~1.5k)
   - `deputados_profiles_insert.sql` - Perfis dos deputados
6. **Respostas** - Dados de survey:
   - `voxdem_data_responses_insert.sql` - Respostas da população geral (~310k - pode levar 1-2 min)
   - `deputados_responses_insert.sql` - Respostas dos deputados (~4k)

### Docker (Automático)

Na primeira vez que você executar `docker-compose up`, o PostgreSQL automaticamente:
- Executa o script `init-database.sql` localizado em `/docker-entrypoint-initdb.d/`
- Todos os arquivos SQL da pasta `sqlinserts/` são montados e executados na ordem correta
- O processo completo leva aproximadamente 3-5 minutos
- Após a conclusão, exibe estatísticas de quantas linhas foram carregadas em cada tabela

### Local (Manual)

Consulte [DATABASE_INIT.md](DATABASE_INIT.md) para instruções detalhadas sobre inicialização local.

```powershell
# Inicialização simples
.\init-database.ps1

# Recriar banco existente
.\init-database.ps1 -DropExisting -Force
```

## Endpoints Principais

### Análise de Survey

```
GET /api/charts/question/:questionId/profile/:profileAttribute
```

Retorna análise cruzada de uma pergunta por atributo de perfil.

**Parâmetros:**
- `questionId`: ID da pergunta
- `profileAttribute`: Atributo para cruzamento (ex: `gender`, `age_range`, `state`)

**Exemplo:**
```bash
curl http://localhost:3000/api/charts/question/1/profile/gender
```

### Documentação Completa

- Swagger/OpenAPI: [api-documentation.yaml](api-documentation.yaml)
- Detalhes da API: (adicionar link quando disponível)

## Scripts Disponíveis

```bash
# Desenvolvimento
npm run dev          # Inicia servidor com hot-reload

# Produção
npm run build        # Compila TypeScript
npm start            # Inicia servidor compilado

# Banco de Dados
.\init-database.ps1  # Inicializa banco local
```

## Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto:

```env
# Servidor
NODE_ENV=development
PORT=3000

# Banco de Dados
DATABASE_HOST=localhost
DATABASE_PORT=5433
DATABASE_NAME=voxdem_survey
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
```

### Docker

As variáveis são configuradas automaticamente no `docker-compose.yml`.

## Desenvolvimento

### Adicionar Nova Entidade

1. Crie a entidade em `src/entities/`
2. Adicione ao `data-source.ts`
3. Execute migrations se necessário

### Adicionar Novo Endpoint

1. Crie o controller em `src/controllers/`
2. Adicione a rota em `src/routes/`
3. Registre a rota no `src/index.ts`

## Banco de Dados

### Schema

O banco possui as seguintes tabelas principais:

- `profiles` - Perfis demográficos dos respondentes (~1.5k)
- `questions` - Perguntas do survey (~100-200)
- `answer_options` - Opções de resposta (~1.5-2k)
- `survey_responses` - Respostas individuais (~310k)

Além de ~30-40 tabelas de lookup (estados, regiões, faixas etárias, etc.)

### Relacionamentos

```
profiles (1) ----< (N) survey_responses (N) >---- (1) questions
                         |
                         |
                         v
                  answer_options (1)
```

## Performance

- **Respostas**: ~310.000 registros
- **Tempo de query típico**: 50-200ms (com índices)
- **Inicialização completa**: ~2-3 minutos (primeira vez)

## Troubleshooting

### Porta 5433 já em uso

Edite `docker-compose.yml` e altere a porta:
```yaml
ports:
  - "5434:5432"  # Mude 5433 para outra porta
```

### Banco não inicializa

```bash
# Remova o volume e recrie
docker-compose down
docker volume rm codigo_postgres_data
docker-compose up -d
```

### Erros de conexão

Verifique se o PostgreSQL está rodando:
```bash
docker-compose ps
# ou
pg_isready -h localhost -p 5433 -U postgres
```

## Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## Licença

[Adicionar informações de licença]

## Contato

[Adicionar informações de contato]

## Links Úteis

- [Documentação TypeORM](https://typeorm.io/)
- [Express.js](https://expressjs.com/)
- [PostgreSQL](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)
