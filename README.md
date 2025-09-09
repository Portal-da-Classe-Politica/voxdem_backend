# VoxDem Chart API v2.1.0 - Dados Otimizados para Gráficos

API REST simplificada para geração de gráficos com dados da pesquisa VoxDem. Focada em fornecer dados prontos para Chart.js com 4 endpoints essenciais.

## 🆕 Novidades v2.1.0

### Labels Detalhadas com Códigos
- **`labelsDetailed`**: Novo campo com objetos `{code, label, display}`
- **Compatibilidade mantida**: Campo `labels` tradicional preservado
- **Ordenação automática**: Resultados ordenados por `answer_code` crescente
- **Frontend flexível**: Escolha entre labels simples ou detalhadas

### Exemplo das Novas Labels
```json
{
  "labels": ["Muito satisfeito", "Satisfeito"],           // Compatível Chart.js
  "labelsDetailed": [                                     // Novo!
    {
      "code": "1",
      "label": "Muito satisfeito", 
      "display": "1 - Muito satisfeito"
    },
    {
      "code": "2",
      "label": "Satisfeito",
      "display": "2 - Satisfeito"
    }
  ]
}
```

## 🚀 Funcionalidades

### API Simplificada para Gráficos
- **4 endpoints essenciais**: Foco na geração de gráficos
- **Chart.js Ready**: Dados formatados para uso direto no Chart.js
- **Labels detalhadas**: Códigos + textos das respostas incluídos
- **Ordenação automática**: Por answer_code crescente
- **Performance otimizada**: Queries diretas na tabela response_analysis
- **Zero configuração**: Estruturas de dados prontas para uso

### Recursos Técnicos
- **Base de dados otimizada**: 309.064 respostas processadas
- **Answer_groups otimizados**: 54 grupos com descrições atualizadas (100% otimização)
- **Sem duplicatas**: Nomes únicos e descrições categorizadas
- **Queries diretas**: Uso da view response_analysis para máxima performance
- **Labels com código**: Suporte a `labelsDetailed` com answer_code
- **Ordenação garantida**: Resultados ordenados por código crescente

## 📊 Endpoints da API (4 Essenciais)

### 🏥 Status
- `GET /` - Informações da API Chart v2.0.0
- `GET /api/health` - Status de saúde e conectividade

### 📋 Lista de Perguntas
- `GET /api/questions` - Lista todas as perguntas ativas com metadados

### 👥 Atributos de Perfil  
- `GET /api/profile-attributes` - Lista atributos disponíveis para cruzamento

### 📈 Gráficos Simples
- `GET /api/chart/{questionCode}` - Dados para gráfico de barras/pizza de uma pergunta

### 📊 Gráficos com Perfil
- `GET /api/chart/{questionCode}/{profileAttribute}` - Dados para gráfico de barras agrupadas (pergunta x perfil)

## 🔧 Instalação e Configuração

### Pré-requisitos
- Node.js 18+
- PostgreSQL 13+ **OU** Docker 20.10+
- npm ou yarn

### Opção 1: 🐳 Docker (Recomendado)
```bash
# Início rápido com Docker Compose
docker-compose up -d

# Verificar funcionamento
curl http://localhost:3000/api/health

# Ver logs
docker-compose logs -f
```

**Vantagens do Docker:**
- ✅ PostgreSQL incluído e pré-configurado
- ✅ Banco de dados restaurado automaticamente
- ✅ Zero configuração necessária
- ✅ Ambiente isolado e reproduzível

📖 **Guia completo**: [DOCKER_GUIDE.md](./DOCKER_GUIDE.md)

### Opção 2: Instalação Manual

#### Configuração do Banco
```bash
# Configurar variáveis de ambiente
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=postgres
DB_NAME=voxdem_survey
```

#### Instalação
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

## 📊 Estrutura dos Dados para Chart.js

### Endpoint: /api/chart/{questionCode}
Retorna dados prontos para Chart.js (gráfico de pizza ou barras) com **labels detalhadas**:

```json
{
  "success": true,
  "data": {
    "question": {
      "code": "P01", 
      "text": "Pergunta sobre satisfação"
    },
    "chartData": {
      "labels": ["Muito satisfeito", "Satisfeito", "Insatisfeito"],
      "labelsDetailed": [
        {
          "code": "1",
          "label": "Muito satisfeito",
          "display": "1 - Muito satisfeito"
        },
        {
          "code": "2", 
          "label": "Satisfeito",
          "display": "2 - Satisfeito"
        },
        {
          "code": "3",
          "label": "Insatisfeito", 
          "display": "3 - Insatisfeito"
        }
      ],
      "datasets": [{
        "data": [1250, 2100, 890],
        "backgroundColor": ["#FF6384", "#36A2EB", "#FFCE56"],
        "borderColor": ["#FF6384", "#36A2EB", "#FFCE56"],
        "borderWidth": 1
      }]
    },
    "totalResponses": 4240
  }
}
```

### Endpoint: /api/chart/{questionCode}/{profile}
Retorna dados para gráfico de barras agrupadas:

```json
{
  "success": true,
  "data": {
    "question": {
      "code": "P01",
      "text": "Pergunta sobre satisfação"
    },
    "profileAttribute": "gender",
    "chartData": {
      "labels": ["Muito satisfeito", "Satisfeito", "Insatisfeito"],
      "labelsDetailed": [
        {
          "code": "1",
          "label": "Muito satisfeito",
          "display": "1 - Muito satisfeito"
        },
        {
          "code": "2",
          "label": "Satisfeito", 
          "display": "2 - Satisfeito"
        },
        {
          "code": "3",
          "label": "Insatisfeito",
          "display": "3 - Insatisfeito"
        }
      ],
      "datasets": [
        {
          "label": "Masculino",
          "data": [620, 1050, 440],
          "backgroundColor": "#36A2EB"
        },
        {
          "label": "Feminino", 
          "data": [630, 1050, 450],
          "backgroundColor": "#FF6384"
        }
      ]
    },
    "totalResponses": 4240
  }
}
```

## 📖 Documentação da API

### Documentação OpenAPI/Swagger
A documentação completa da API Chart v2.1.0 está disponível em:
- **Arquivo**: `api-documentation.yaml`
- **Versão**: OpenAPI 3.0 com exemplos Chart.js e labels detalhadas
- **Conteúdo**: 4 endpoints essenciais com schemas otimizados

### Visualização da Documentação
Para visualizar a documentação interativa:

1. **Swagger Editor Online**:
   - Acesse: https://editor.swagger.io/
   - Cole o conteúdo de `api-documentation.yaml`

2. **VS Code com extensão**:
   - Instale: "OpenAPI (Swagger) Editor"
   - Abra o arquivo `api-documentation.yaml`

## 💡 Exemplos de Uso com Chart.js

### Gráfico de Pizza Simples
```javascript
// 1. Buscar dados da API
const response = await fetch('/api/chart/P01');
const apiData = await response.json();

// 2. Usar diretamente no Chart.js
new Chart(ctx, {
  type: 'pie',
  data: apiData.data.chartData,
  options: {
    responsive: true,
    plugins: {
      title: {
        display: true,
        text: apiData.data.question.text
      }
    }
  }
});
```

### Gráfico de Barras com Perfil
```javascript
// 1. Buscar dados cruzados
const response = await fetch('/api/chart/P01/gender');
const apiData = await response.json();

// 2. Criar gráfico de barras agrupadas
new Chart(ctx, {
  type: 'bar',
  data: apiData.data.chartData,
  options: {
    responsive: true,
    scales: {
      x: { stacked: false },
      y: { stacked: false }
    },
    plugins: {
      title: {
        display: true,
        text: `${apiData.data.question.text} por ${apiData.data.profileAttribute}`
      }
    }
  }
});
```

### Listar Perguntas Disponíveis
```javascript
// Buscar todas as perguntas
const questions = await fetch('/api/questions');
const data = await questions.json();

console.log(`${data.data.length} perguntas disponíveis`);
data.data.forEach(q => {
  console.log(`${q.code}: ${q.text}`);
});
```

### Atributos de Perfil
```javascript
// Buscar atributos para cruzamento
const profiles = await fetch('/api/profile-attributes');
const data = await profiles.json();

// Resultados: gender, age_range, education, race, region, state
console.log('Perfis disponíveis:', data.data);
```

### 🆕 Labels Detalhadas (v2.1.0)
```javascript
// Buscar dados com labels detalhadas
const response = await fetch('/api/chart/P01');
const apiData = await response.json();

// Usar labels simples (compatível com Chart.js)
const simpleLabels = apiData.data.chartData.labels;
console.log(simpleLabels); // ["Muito satisfeito", "Satisfeito", ...]

// Usar labels detalhadas (novo!)
const detailedLabels = apiData.data.chartData.labelsDetailed;
detailedLabels.forEach(item => {
  console.log(`Código: ${item.code}`);      // "1"
  console.log(`Label: ${item.label}`);      // "Muito satisfeito"
  console.log(`Display: ${item.display}`);  // "1 - Muito satisfeito"
});

// Personalizar tooltips no Chart.js
new Chart(ctx, {
  type: 'pie',
  data: apiData.data.chartData,
  options: {
    plugins: {
      tooltip: {
        callbacks: {
          label: function(context) {
            const detailLabel = detailedLabels[context.dataIndex];
            return `${detailLabel.display}: ${context.parsed}`;
          }
        }
      }
    }
  }
});
```

## 🎯 Casos de Uso Frontend

### 1. Dashboard de Satisfação
```javascript
// Gráfico de pizza para uma pergunta
async function createSatisfactionChart(questionCode) {
  const response = await fetch(`/api/chart/${questionCode}`);
  const data = await response.json();
  
  return new Chart(canvas, {
    type: 'pie',
    data: data.data.chartData
  });
}
```

### 2. Análise Comparativa por Perfil
```javascript
// Gráfico de barras agrupadas por gênero
async function createGenderComparisonChart(questionCode) {
  const response = await fetch(`/api/chart/${questionCode}/gender`);
  const data = await response.json();
  
  return new Chart(canvas, {
    type: 'bar',
    data: data.data.chartData,
    options: {
      scales: {
        x: { stacked: false },
        y: { stacked: false }
      }
    }
  });
}
```

### 3. Múltiplos Gráficos em Dashboard
```javascript
// Criar dashboard com vários gráficos
async function createDashboard() {
  const questions = await fetch('/api/questions');
  const questionList = await questions.json();
  
  // Criar gráfico para cada pergunta
  for (const question of questionList.data.slice(0, 6)) {
    const chartData = await fetch(`/api/chart/${question.code}`);
    const data = await chartData.json();
    
    // Criar canvas dinamicamente
    const canvas = document.createElement('canvas');
    document.getElementById('dashboard').appendChild(canvas);
    
    // Criar gráfico
    new Chart(canvas, {
      type: 'pie',
      data: data.data.chartData,
      options: {
        plugins: {
          title: {
            display: true,
            text: question.text
          }
        }
      }
    });
  }
}
```

## 🗄️ Estrutura do Banco (Otimizada)

### Tabelas Principais
- **questions**: 179 perguntas ativas da pesquisa
- **answer_groups**: 54 grupos otimizados (100% sem duplicatas)
- **answer_options**: Opções de resposta categorizadas
- **response_analysis**: View otimizada com 309.064 respostas

### Otimizações Implementadas
- **Answer_groups**: Descrições atualizadas e categorizadas
- **Nomes únicos**: Eliminadas todas as duplicatas
- **Categorização semântica**: Escalas, frequência, importância, etc.
- **Queries diretas**: Uso da view response_analysis
- **Labels com código**: answer_code incluído em todas as respostas
- **Ordenação automática**: Resultados ordenados por answer_code crescente

### Perfis Demográficos Disponíveis
- **gender**: Masculino, Feminino  
- **age_range**: 5 faixas etárias (16-24, 25-34, 35-44, 45-54, 55+)
- **education**: 15 níveis de escolaridade
- **race**: 5 categorias (Branca, Preta, Parda, Amarela, Indígena)
- **region**: 5 regiões do Brasil (Norte, Nordeste, Centro-Oeste, Sudeste, Sul)
- **state**: Estados brasileiros

## ⚡ Performance

### API Simplificada
- **4 endpoints essenciais**: Foco em gráficos
- **Chart.js Ready**: Zero processamento no frontend
- **Labels detalhadas**: Códigos + textos de resposta incluídos
- **Ordenação garantida**: Por answer_code crescente
- **Queries otimizadas**: Uso direto da view response_analysis
- **Estruturas pré-formatadas**: Cores e labels incluídos

### Métricas de Performance
- **Tempo de resposta**: < 200ms para gráficos simples
- **Dados prontos**: Formato Chart.js nativo com labels detalhadas
- **Base otimizada**: 100% de utilização (0% dados órfãos)
- **Answer_groups**: 100% otimizados e categorizados
- **Ordenação eficiente**: ORDER BY answer_code::INTEGER nas queries

### Otimizações de Banco
- **View response_analysis**: Elimina joins complexos
- **Descrições categorizadas**: Answer_groups semanticamente organizados
- **Nomes únicos**: Zero conflitos ou duplicatas
- **Cache eficiente**: Metadados em memória

## 🛠️ Tecnologias

- **Backend**: Node.js + TypeScript + Express
- **Banco**: PostgreSQL com view response_analysis otimizada
- **ORM**: TypeORM para type safety
- **API**: 4 endpoints REST focados em Chart.js
- **Documentação**: OpenAPI 3.0 com exemplos práticos

## 📚 Estrutura do Projeto

```
src/
├── entities/          # Entidades TypeORM otimizadas
├── services/          # AnalysisService simplificado
├── routes/           # chartRoutes.ts (4 endpoints)
└── data-source.ts    # Configuração do banco

voxdem_survey_dump.sql    # Dump do banco de dados (65MB, 309k respostas)

docker/               # Configuração Docker
├── Dockerfile        # Multi-stage build
├── docker-compose.yml # Orquestração de serviços
├── docker-entrypoint.sh # Script de inicialização
├── deploy.sh         # Script de deploy (Linux/macOS)
├── deploy.bat        # Script de deploy (Windows)
└── DOCKER_GUIDE.md   # Guia completo Docker

api-documentation.yaml # Swagger Chart API v2.0.0
OPTIMIZATION_REPORT.md # Relatório de otimizações
.gitignore            # Scripts e dados sensíveis excluídos
```

## 🔧 Scripts de Otimização

Foram criados scripts para manutenção e otimização:

```bash
# Verificar schema do banco
node check-schema.js

# Gerar dump do banco (já executado)
node generate-dump.js

# Otimizar answer_groups (já executado)
node optimize-answer-groups.js

# Corrigir nomes duplicados (já executado) 
node fix-duplicate-names.js
```

### Resultados das Otimizações
- ✅ **54 grupos** de respostas otimizados (100%)
- ✅ **0 duplicatas** remanescentes  
- ✅ **100% categorização** semântica implementada
- ✅ **API simplificada** para Chart.js pronta
- ✅ **Labels detalhadas** com answer_code implementadas (v2.1.0)
- ✅ **Ordenação automática** por answer_code crescente (v2.1.0)
- ✅ **Dump completo** gerado (65MB com 309k respostas)
- ✅ **Docker containerizado** com PostgreSQL integrado

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma feature branch
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 Licença


