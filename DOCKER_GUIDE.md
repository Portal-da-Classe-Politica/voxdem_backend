# 🐳 VoxDem Chart API - Guia Docker

Este guia explica como usar o Docker para executar a VoxDem Chart API v2.0.0 com PostgreSQL integrado.

## 📋 Pré-requisitos

- Docker 20.10+
- Docker Compose 2.0+
- 2GB de RAM disponível
- 500MB de espaço em disco

## 🚀 Início Rápido

### Opção 1: Docker Compose (Recomendado)
```bash
# 1. Clonar o repositório
git clone https://github.com/Portal-da-Classe-Politica/voxdem_backend.git
cd voxdem_backend

# 2. Executar com Docker Compose
docker-compose up -d

# 3. Verificar se está funcionando
curl http://localhost:3000/api/health
```

### Opção 2: Scripts Automáticos
```bash
# Linux/macOS
chmod +x deploy.sh
./deploy.sh

# Windows
deploy.bat
```

### Opção 3: Build Manual
```bash
# 1. Build da imagem
docker build -t voxdem-chart-api:latest .

# 2. Executar container
docker run -d \
  --name voxdem-api \
  -p 3000:3000 \
  -p 5432:5432 \
  -e DB_PASSWORD=voxdem2024 \
  voxdem-chart-api:latest
```

## 🔧 Configuração

### Variáveis de Ambiente
```bash
NODE_ENV=production          # Ambiente de execução
PORT=3000                   # Porta da API
DB_HOST=localhost           # Host do PostgreSQL
DB_PORT=5432               # Porta do PostgreSQL  
DB_USERNAME=postgres       # Usuário do banco
DB_PASSWORD=voxdem2024     # Senha do banco
DB_NAME=voxdem_survey      # Nome do banco
```

### Portas Expostas
- **3000**: API REST (VoxDem Chart API)
- **5432**: PostgreSQL (banco de dados)

## 📊 Funcionalidades do Container

### Inicialização Automática
1. **PostgreSQL**: Instalação e configuração automática
2. **Banco de dados**: Restauração do dump (309.064 respostas)
3. **API**: Inicialização do serviço Node.js
4. **Health checks**: Monitoramento automático

### Persistência de Dados
- Volume `postgres_data`: Dados do PostgreSQL persistidos
- Volume `logs`: Logs da aplicação (opcional)

## 🛠️ Comandos Úteis

### Gerenciamento de Containers
```bash
# Iniciar serviços
docker-compose up -d

# Parar serviços
docker-compose down

# Reiniciar serviços
docker-compose restart

# Ver logs em tempo real
docker-compose logs -f

# Ver status dos containers
docker-compose ps
```

### Acesso ao Banco de Dados
```bash
# Conectar ao PostgreSQL via container
docker-compose exec voxdem-api su postgres -c "psql voxdem_survey"

# Conectar externamente
psql -h localhost -p 5432 -U postgres -d voxdem_survey
```

### Monitoramento
```bash
# Health check manual
curl http://localhost:3000/api/health

# Estatísticas do container
docker stats voxdem-chart-api

# Logs específicos
docker logs voxdem-chart-api --tail=100
```

## 📈 Endpoints Disponíveis

Após inicialização, a API estará disponível em `http://localhost:3000`:

```bash
# Status da API
curl http://localhost:3000/

# Saúde do sistema
curl http://localhost:3000/api/health

# Lista de perguntas
curl http://localhost:3000/api/questions

# Gráfico simples
curl http://localhost:3000/api/chart/P01

# Gráfico com perfil
curl http://localhost:3000/api/chart/P01/gender
```

## 🔍 Troubleshooting

### Container não inicia
```bash
# Verificar logs
docker-compose logs voxdem-api

# Verificar recursos
docker system df
```

### Banco de dados não conecta
```bash
# Verificar PostgreSQL
docker-compose exec voxdem-api su postgres -c "pg_isready"

# Verificar dados
docker-compose exec voxdem-api su postgres -c "psql voxdem_survey -c 'SELECT count(*) FROM response_analysis;'"
```

### API não responde
```bash
# Verificar processo Node.js
docker-compose exec voxdem-api ps aux | grep node

# Verificar conectividade
docker-compose exec voxdem-api netstat -tlnp | grep 3000
```

### Problemas de performance
```bash
# Verificar recursos
docker stats voxdem-chart-api

# Verificar espaço em disco
docker system df
```

## 🔧 Customização

### Modificar configurações
1. Editar `docker-compose.yml`
2. Ajustar variáveis de ambiente
3. Reiniciar containers: `docker-compose restart`

### Backup do banco
```bash
# Criar backup
docker-compose exec voxdem-api su postgres -c "pg_dump voxdem_survey > /tmp/backup.sql"

# Copiar backup
docker cp voxdem-chart-api:/tmp/backup.sql ./backup.sql
```

### Logs personalizados
```bash
# Configurar volume de logs no docker-compose.yml
volumes:
  - ./logs:/app/logs
```

## 🚀 Deploy em Produção

### Configurações recomendadas
```yaml
# docker-compose.prod.yml
version: '3.8'
services:
  voxdem-api:
    build: .
    restart: always
    environment:
      - NODE_ENV=production
      - DB_PASSWORD=${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./logs:/app/logs
    deploy:
      resources:
        limits:
          memory: 1G
          cpus: '0.5'
```

### Segurança
- Usar senhas fortes para `DB_PASSWORD`
- Configurar firewall para portas 3000 e 5432
- Implementar proxy reverso (nginx/traefik)
- Configurar SSL/TLS

## 📚 Estrutura da Imagem

```
/app/
├── dist/                 # Aplicação Node.js compilada
├── voxdem_survey_dump.sql # Dump do banco de dados (65MB)
├── node_modules/         # Dependências
├── docker-entrypoint.sh  # Script de inicialização
└── package.json          # Configuração do projeto

/var/lib/postgresql/data/  # Dados do PostgreSQL
```

## 📄 Licença

Este projeto está licenciado sob os termos definidos no projeto principal VoxDem.
