#!/bin/bash
# =====================================================
# VoxDem Database Initialization Script (Docker)
# =====================================================

set -e

echo "==========================================="
echo "VoxDem Database Initialization"
echo "==========================================="

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
until pg_isready -h localhost -U "$POSTGRES_USER"; do
  sleep 1
done

echo "PostgreSQL is ready!"

# Check if database already has data
EXISTING_TABLES=$(psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';")

if [ "$EXISTING_TABLES" -gt "0" ]; then
  echo "Database already initialized. Skipping..."
  exit 0
fi

echo "Initializing database..."

# Run the initialization script
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/init-database.sql

echo "==========================================="
echo "Database initialization complete!"
echo "==========================================="
