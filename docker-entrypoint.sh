#!/bin/sh
# VoxDem Chart API - Docker Entrypoint Script
# Initializes PostgreSQL, restores database, and starts the API service

set -e

echo "🐳 VoxDem Chart API v2.0.0 - Inicializando Container..."

# Function to wait for postgres
wait_for_postgres() {
    echo "⏳ Aguardando PostgreSQL ficar disponível..."
    while ! pg_isready -h localhost -p 5432 -U postgres > /dev/null 2>&1; do
        sleep 1
    done
    echo "✅ PostgreSQL está pronto!"
}

# Function to initialize database
init_database() {
    echo "🗄️ Inicializando banco de dados PostgreSQL..."
    
    # Initialize PostgreSQL data directory
    if [ ! -s "/var/lib/postgresql/data/PG_VERSION" ]; then
        echo "📦 Criando cluster PostgreSQL..."
        su postgres -c "initdb -D /var/lib/postgresql/data --encoding=UTF8 --locale=C"
        
        # Configure PostgreSQL
        echo "⚙️ Configurando PostgreSQL..."
        cat >> /var/lib/postgresql/data/postgresql.conf <<EOF
listen_addresses = '*'
port = 5432
max_connections = 100
shared_buffers = 128MB
effective_cache_size = 512MB
maintenance_work_mem = 64MB
checkpoint_completion_target = 0.9
wal_buffers = 16MB
default_statistics_target = 100
random_page_cost = 4
effective_io_concurrency = 2
work_mem = 4MB
min_wal_size = 1GB
max_wal_size = 4GB
EOF
        
        # Configure authentication
        cat > /var/lib/postgresql/data/pg_hba.conf <<EOF
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             postgres                                trust
local   all             all                                     trust
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5
host    all             all             0.0.0.0/0               md5
EOF
    fi
    
    # Start PostgreSQL
    echo "🚀 Iniciando PostgreSQL..."
    su postgres -c "pg_ctl -D /var/lib/postgresql/data -l /var/lib/postgresql/data/logfile start"
    
    # Wait for PostgreSQL to be ready
    wait_for_postgres
    
    # Set password for postgres user
    echo "🔐 Configurando senha do usuário postgres..."
    su postgres -c "psql -c \"ALTER USER postgres PASSWORD '$DB_PASSWORD';\""
}

# Function to restore database
restore_database() {
    echo "📚 Verificando se banco voxdem_survey existe..."
    
    DB_EXISTS=$(su postgres -c "psql -lqt | cut -d \| -f 1 | grep -qw voxdem_survey && echo 'yes' || echo 'no'")
    
    if [ "$DB_EXISTS" = "no" ]; then
        echo "🔄 Restaurando banco de dados VoxDem..."
        
        # Create database
        echo "🆕 Criando banco de dados voxdem_survey..."
        su postgres -c "createdb voxdem_survey"
        
        # Restore from dump
        echo "📥 Restaurando dados do dump..."
        if [ -f "/app/voxdem_survey_dump.sql" ]; then
            su postgres -c "psql voxdem_survey < /app/voxdem_survey_dump.sql"
            echo "✅ Banco de dados restaurado com sucesso!"
        else
            echo "⚠️ Arquivo de dump não encontrado. Criando banco vazio..."
            su postgres -c "psql voxdem_survey -c 'SELECT version();'"
        fi
        
        # Verify restoration
        echo "🔍 Verificando restauração..."
        TABLES_COUNT=$(su postgres -c "psql voxdem_survey -t -c \"SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public';\"" | tr -d ' ')
        echo "📊 Tabelas encontradas: $TABLES_COUNT"
        
        if [ "$TABLES_COUNT" -gt "0" ]; then
            RESPONSES_COUNT=$(su postgres -c "psql voxdem_survey -t -c \"SELECT count(*) FROM response_analysis;\"" 2>/dev/null | tr -d ' ' || echo "0")
            echo "📈 Respostas na base: $RESPONSES_COUNT"
        fi
    else
        echo "✅ Banco de dados voxdem_survey já existe!"
    fi
}

# Function to start API service
start_api() {
    echo "🚀 Iniciando VoxDem Chart API v2.0.0..."
    
    # Verify database connection
    echo "🔗 Testando conexão com banco de dados..."
    until su postgres -c "psql voxdem_survey -c 'SELECT 1;'" > /dev/null 2>&1; do
        echo "⏳ Aguardando conexão com banco..."
        sleep 2
    done
    
    echo "✅ Conexão com banco de dados confirmada!"
    
    # Start Node.js application
    echo "🌐 Iniciando servidor Node.js na porta $PORT..."
    exec node dist/index.js
}

# Main execution flow
main() {
    echo "🔧 Configuração do ambiente:"
    echo "   - Node.js: $(node --version)"
    echo "   - PostgreSQL: $(postgres --version | head -n1)"
    echo "   - Porta API: $PORT"
    echo "   - Banco: $DB_NAME"
    echo ""
    
    # Initialize PostgreSQL
    init_database
    
    # Restore VoxDem database
    restore_database
    
    # Start API service
    start_api
}

# Handle signals for graceful shutdown
cleanup() {
    echo "🛑 Recebido sinal de parada..."
    echo "⏹️ Parando PostgreSQL..."
    su postgres -c "pg_ctl -D /var/lib/postgresql/data stop -m fast" || true
    echo "👋 Container finalizado."
    exit 0
}

trap cleanup TERM INT

# Run main function
main
