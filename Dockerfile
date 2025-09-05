# VoxDem Chart API v2.0.0 - Dockerfile
# Multi-stage build for production-ready container

# Stage 1: Build TypeScript
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
COPY tsconfig.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY src/ ./src/

# Build TypeScript
RUN npm run build

# Stage 2: Production Runtime
FROM node:18-alpine AS runtime

# Install PostgreSQL client and server
RUN apk add --no-cache postgresql postgresql-contrib

# Create app directory
WORKDIR /app

# Create postgres user and directories
RUN addgroup -g 70 postgres && \
    adduser -u 70 -G postgres -h /var/lib/postgresql -s /bin/sh -D postgres && \
    mkdir -p /var/lib/postgresql/data && \
    mkdir -p /var/run/postgresql && \
    chown -R postgres:postgres /var/lib/postgresql && \
    chown -R postgres:postgres /var/run/postgresql

# Copy built application
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY package.json ./

# Copy database dump file
COPY voxdem_survey_dump.sql ./voxdem_survey_dump.sql

# Create initialization script
COPY docker-entrypoint.sh ./docker-entrypoint.sh
RUN chmod +x ./docker-entrypoint.sh

# Environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV DB_HOST=localhost
ENV DB_PORT=5432
ENV DB_USERNAME=postgres
ENV DB_PASSWORD=voxdem2024
ENV DB_NAME=voxdem_survey

# Expose ports
EXPOSE 3000 5432

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:3000/api/health || exit 1

# Run the application
CMD ["./docker-entrypoint.sh"]
