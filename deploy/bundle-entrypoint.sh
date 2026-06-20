#!/bin/sh
set -e

# Hugging Face Spaces 使用 PORT；Sub2API 使用 SERVER_PORT。
if [ -n "${PORT:-}" ]; then
    export SERVER_PORT="${PORT}"
fi
export SERVER_HOST="${SERVER_HOST:-0.0.0.0}"

export AUTO_SETUP="${AUTO_SETUP:-true}"
export DATABASE_HOST="${DATABASE_HOST:-127.0.0.1}"
export DATABASE_PORT="${DATABASE_PORT:-5432}"
export REDIS_HOST="${REDIS_HOST:-127.0.0.1}"
export REDIS_PORT="${REDIS_PORT:-6379}"

export POSTGRES_USER="${POSTGRES_USER:-sub2api}"
export POSTGRES_DB="${POSTGRES_DB:-sub2api}"
export POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-sub2api}"

export DATABASE_USER="${DATABASE_USER:-$POSTGRES_USER}"
export DATABASE_DBNAME="${DATABASE_DBNAME:-$POSTGRES_DB}"
export DATABASE_PASSWORD="${DATABASE_PASSWORD:-$POSTGRES_PASSWORD}"

mkdir -p /app/data /var/log/supervisor
chown -R sub2api:sub2api /app/data 2>/dev/null || true

exec /usr/bin/supervisord -c /etc/supervisord.conf
