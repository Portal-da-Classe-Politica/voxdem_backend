# VoxDem API - Análise de Frequências e Cruzamentos

API REST para análise de dados de pesquisa VoxDem com funcionalidades avançadas de análise estatística e cruzamento de dados demográficos.

## 🚀 Funcionalidades

### Análise de Frequências
- **Frequências por pergunta**: Obtenha distribuição de respostas para qualquer pergunta
- **Filtros por tipo**: Liste perguntas por categoria (escala, categórica, texto)
- **Estatísticas de escala**: Médias, valores mín/máx para perguntas de escala 0-10

### Cruzamento de Dados
- **Análise cruzada**: Cruze qualquer pergunta com atributos demográficos
- **Atributos de perfil**: Sexo, idade, escolaridade, raça, região, estado
- **Percentuais automáticos**: Cálculos automáticos de distribuição por perfil

### Recursos Técnicos
- **Base de dados otimizada**: 309.064 respostas com 100% de utilização
- **Tipos de pergunta**: Escalas (0-10), categóricas e texto livre
- **Performance**: Queries otimizadas com views pré-computadas

## 📊 Endpoints Principais

### 🏥 Status
- `GET /` - Informações gerais da API
- `GET /api/health` - Status de saúde e conectividade

### 📋 Perguntas
- `GET /api/questions` - Lista todas as perguntas disponíveis
- `GET /api/questions/by-type/{type}` - Filtra por tipo (scale|categorical|text)

### 📈 Análise de Frequências
- `GET /api/frequency/{questionCode}` - Frequências para uma pergunta
- `GET /api/scale-stats/{questionCode}` - Estatísticas para escalas

### 🎯 Análise de Perfil
- `GET /api/profile-attributes` - Lista atributos de perfil disponíveis
- `GET /api/crosstab/{questionCode}/{profileAttribute}` - Cruzamento pergunta x perfil

## 🔧 Instalação e Configuração

### Pré-requisitos
- Node.js 18+
- PostgreSQL 13+
- npm ou yarn

### Configuração do Banco
```bash
# Configurar variáveis de ambiente
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=postgres
DB_NAME=voxdem_survey
```

### Instalação
```bash
# Instalar dependências
npm install

# Compilar TypeScript
npm run build

# Executar em desenvolvimento
npm run dev

# Executar em produção
npm start
```

## 📖 Documentação da API

### Documentação OpenAPI/Swagger
A documentação completa da API está disponível em formato OpenAPI 3.0:
- **Arquivo**: `api-documentation.yaml`
- **Formato**: YAML padronizado
- **Conteúdo**: Schemas, endpoints, exemplos e responses

### Visualização da Documentação
Para visualizar a documentação interativa:

1. **Swagger Editor Online**:
   - Acesse: https://editor.swagger.io/
   - Cole o conteúdo de `api-documentation.yaml`

2. **VS Code com extensão**:
   - Instale: "OpenAPI (Swagger) Editor"
   - Abra o arquivo `api-documentation.yaml`

3. **Swagger UI Local**:
   ```bash
   npx swagger-ui-serve api-documentation.yaml
   ```

## 💡 Exemplos de Uso

### Listar Perguntas Disponíveis
```bash
curl http://localhost:3000/api/questions
```

### Análise de Frequência
```bash
# Pergunta P01 - Satisfação com democracia
curl http://localhost:3000/api/frequency/P01
```

### Cruzamento por Gênero
```bash
# P01 cruzado com sexo
curl http://localhost:3000/api/crosstab/P01/gender
```

### Estatísticas de Escala
```bash
# P06 - Pergunta de escala 0-10
curl http://localhost:3000/api/scale-stats/P06
```

## 🎯 Casos de Uso

### 1. Dashboard de Satisfação
```javascript
// Buscar satisfação geral por região
const satisfaction = await fetch('/api/crosstab/P01/region');
const data = await satisfaction.json();
```

### 2. Análise Demográfica
```javascript
// Comparar respostas por faixa etária
const ageAnalysis = await fetch('/api/crosstab/P06/age_range');
```

### 3. Relatórios Automáticos
```javascript
// Gerar estatísticas para todas as escalas
const scaleQuestions = await fetch('/api/questions/by-type/scale');
for(const q of scaleQuestions.data) {
  const stats = await fetch(`/api/scale-stats/${q.code}`);
}
```

## 🗄️ Estrutura do Banco

### Tabelas Principais
- **questions**: Perguntas da pesquisa (179 ativas)
- **answer_groups**: Grupos de respostas (54 ativos)
- **answer_options**: Opções de resposta (391 ativas)
- **survey_responses**: Respostas dos participantes (309.064)

### Views Otimizadas
- **response_analysis**: View pré-computada com joins otimizados
- **profile_analysis**: Agregações por perfil demográfico

### Dados Demográficos
- **genders**: Masculino, Feminino
- **age_ranges**: 5 faixas etárias (16-24, 25-34, 35-44, 45-54, 55+)
- **education_levels**: 15 níveis de escolaridade
- **races**: 5 categorias (Branca, Preta, Parda, Amarela, Indígena)
- **regions**: 5 regiões do Brasil

## ⚡ Performance

### Otimizações Implementadas
- **Views materializadas**: Queries complexas pré-computadas
- **Índices estratégicos**: Em chaves de junção e filtros
- **Cleanup automático**: 100% de utilização dos dados
- **Cache de metadados**: Informações de schema em memória

### Métricas
- **Tempo de resposta**: < 200ms para frequências simples
- **Throughput**: > 100 req/s em hardware modesto
- **Utilização**: 0% de dados órfãos ou não utilizados

## 🛠️ Tecnologias

- **Backend**: Node.js + TypeScript + Express
- **Banco**: PostgreSQL 13+ com views otimizadas
- **ORM**: TypeORM para type safety
- **Validação**: Joi para validação de requests
- **Documentação**: OpenAPI 3.0 (Swagger)

## 📚 Estrutura do Projeto

```
src/
├── entities/          # Entidades TypeORM
├── services/          # Lógica de negócio
├── routes/           # Definição de rotas
├── scripts/          # Scripts utilitários
└── data-source.ts    # Configuração do banco

data-sources/         # Dados originais CSV
dist/                # Build de produção
api-documentation.yaml # Documentação Swagger
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma feature branch
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 Licença


