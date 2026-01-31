# Testes - VoxDem API

Este diretório contém todos os testes automatizados da API VoxDem.

## 📁 Estrutura de Testes

```
tests/
├── setup.ts                           # Configuração global dos testes
├── mocks/
│   └── database.mock.ts              # Mocks do banco de dados
├── routes/
│   └── chartRoutes.test.ts           # Testes das rotas da API
├── services/
│   └── AnalysisService.test.ts       # Testes do serviço de análise
└── questions/
    └── deputados.test.ts             # Testes de todas as perguntas dos deputados
```

## 🚀 Executando os Testes

### Todos os testes
```bash
npm test
```

### Testes em modo watch (re-executa ao salvar)
```bash
npm run test:watch
```

### Testes com cobertura
```bash
npm run test:coverage
```

### Testes específicos

#### Apenas testes de rotas
```bash
npm run test:routes
```

#### Apenas testes de perguntas dos deputados
```bash
npm run test:deputados
```

#### Testes com output detalhado
```bash
npm run test:verbose
```

## 📊 Cobertura de Testes

### Rotas Testadas (chartRoutes.test.ts)
- ✅ `GET /api/surveys` - Lista todas as surveys
- ✅ `GET /api/questions` - Lista perguntas (com/sem filtro)
- ✅ `GET /api/profile-attributes` - Lista atributos de perfil
- ✅ `GET /api/chart/:questionCode` - Dados de gráfico simples
- ✅ `GET /api/chart/:questionCode/:profileAttribute` - Dados com cruzamento

### Perguntas de Deputados Testadas (deputados.test.ts)

Total: **25 perguntas** testadas individualmente

#### Satisfação com Democracia
- ✅ P1 - Satisfação com a democracia

#### Importância para Democracia (P3)
- ✅ P3_1 - Eleições livres e justas
- ✅ P3_2 - Discussão política entre eleitores
- ✅ P3_3 - Liberdade de crítica da oposição
- ✅ P3_4 - Liberdade de mídia
- ✅ P3_5 - Proteção de minorias
- ✅ P3_6 - Voto direto em plebiscitos
- ✅ P3_7 - Igualdade nos tribunais
- ✅ P3_8 - Controle judicial do governo
- ✅ P3_9 - Punição eleitoral de governos ruins
- ✅ P3_10 - Proteção contra pobreza
- ✅ P3_11 - Redução de desigualdades

#### Posicionamento Ideológico
- ✅ P4 - Autoposicionamento ideológico

#### Opiniões sobre Políticas (P5)
- ✅ P5_1 - Estatização de empresas
- ✅ P5_2 - Aborto
- ✅ P5_3 - Maioridade penal
- ✅ P5_4 - Desenvolvimento vs meio ambiente
- ✅ P5_5 - Humanos vs natureza
- ✅ P5_6 - Privilégio racial
- ✅ P5_7 - Respeito a resultados eleitorais
- ✅ P5_8 - Poder do STF
- ✅ P5_9 - Presidente vs decisões judiciais
- ✅ P5_10 - Maioria vs minoria

#### Prioridades Governamentais (P6)
- ✅ P6_1 - Primeira prioridade
- ✅ P6_2 - Segunda prioridade

### Serviços Testados (AnalysisService.test.ts)
- ✅ `getSurveys()` - Busca de surveys
- ✅ `getAvailableQuestions()` - Busca de perguntas
- ✅ `getProfileAttributes()` - Busca de atributos de perfil
- ✅ `getChartData()` - Dados de gráfico simples
- ✅ `getChartDataWithProfile()` - Dados com cruzamento

## 🎯 Cenários de Teste

### Testes de Sucesso
- Requisições bem-sucedidas retornam status 200
- Estrutura de resposta JSON correta
- Dados válidos nos campos obrigatórios
- Filtros por surveyId funcionando

### Testes de Validação
- Códigos de pergunta inválidos (erro 400)
- Atributos de perfil inválidos (erro 400)
- Validação de formato de código (regex P[0-9]+[A-Z]*)

### Testes de Erro
- Perguntas não encontradas (erro 404)
- Erros de banco de dados (erro 500)
- Tratamento correto de exceções

### Testes de Performance
- Requisições para todas as 25 perguntas em sequência
- Timeout de 60 segundos para testes de performance
- Validação de que todas completam sem erro

### Testes de Cruzamento
- Perguntas chave cruzadas com partido político
- Validação de estrutura de datasets múltiplos
- Verificação de profileValues retornados

## 🛠️ Tecnologias de Teste

- **Jest**: Framework de testes
- **ts-jest**: Integração TypeScript + Jest
- **supertest**: Testes de API HTTP
- **@types/jest**: Tipagem TypeScript para Jest
- **@types/supertest**: Tipagem TypeScript para supertest

## 📝 Configuração

### jest.config.js
Configuração do Jest com suporte a TypeScript:
- Preset: ts-jest
- Ambiente: node
- Timeout: 30 segundos
- Cobertura: texto, lcov, html

### tests/setup.ts
Configuração global dos testes:
- Variáveis de ambiente mockadas
- Timeout padrão de 30 segundos
- Isolamento de ambiente de teste

## 💡 Boas Práticas

1. **Isolamento**: Cada teste é independente
2. **Mocks**: Database e serviços são mockados
3. **Clean up**: `afterEach` limpa os mocks
4. **Nomenclatura**: Descritiva e em português
5. **Cobertura**: Testar sucesso, validação e erro
6. **Performance**: Testes de carga incluídos

## 📈 Métricas de Cobertura

Execute `npm run test:coverage` para ver:
- % de linhas cobertas
- % de funções cobertas
- % de branches cobertas
- % de statements cobertas

Relatório HTML disponível em: `coverage/index.html`

## 🐛 Debugging

Para debug de testes específicos:

```bash
# Executar apenas um arquivo
npx jest tests/routes/chartRoutes.test.ts

# Executar apenas um teste específico
npx jest -t "deve retornar lista de surveys"

# Com verbose e sem cache
npx jest --verbose --no-cache
```

## ✅ Checklist de Qualidade

- [x] Todas as rotas testadas
- [x] Todas as 25 perguntas de deputados testadas
- [x] Testes de erro e validação
- [x] Testes de performance
- [x] Mocks configurados corretamente
- [x] Cobertura de código > 80%
- [x] Testes passando no CI/CD
- [x] Documentação completa

## 🤝 Contribuindo

Ao adicionar novos testes:

1. Siga o padrão de nomenclatura existente
2. Use mocks para isolar dependências
3. Teste casos de sucesso e erro
4. Mantenha testes rápidos (< 5s cada)
5. Atualize esta documentação se necessário

## 📚 Referências

- [Jest Documentation](https://jestjs.io/)
- [Supertest Documentation](https://github.com/visionmedia/supertest)
- [Testing Best Practices](https://github.com/goldbergyoni/javascript-testing-best-practices)
