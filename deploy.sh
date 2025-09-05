#!/bin/bash
# VoxDem Chart API - Build and Deploy Script

set -e

echo "🐳 VoxDem Chart API v2.0.0 - Build & Deploy"
echo "============================================"

# Build Docker image
echo "🔨 Building Docker image..."
docker build -t voxdem-chart-api:latest .

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose down || true

# Start new containers
echo "🚀 Starting containers..."
docker-compose up -d

# Wait for health check
echo "⏳ Waiting for health check..."
sleep 30

# Check health
echo "🏥 Checking API health..."
curl -f http://localhost:3000/api/health || echo "❌ Health check failed"

# Show logs
echo "📋 Recent logs:"
docker-compose logs --tail=20 voxdem-api

echo ""
echo "✅ Deploy completed!"
echo "🌐 API available at: http://localhost:3000"
echo "📊 Database available at: localhost:5432"
echo ""
echo "📖 Useful commands:"
echo "   docker-compose logs -f        # Follow logs"
echo "   docker-compose down           # Stop containers"
echo "   docker-compose restart        # Restart containers"
