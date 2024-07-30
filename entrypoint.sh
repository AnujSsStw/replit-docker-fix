#!/bin/bash
set -e

echo "Starting entrypoint script..."

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Create and migrate the database
if [ -f /app/bin/rails ]; then
  echo "Using /app/bin/rails"
  /app/bin/rails db:create db:migrate
else
  echo "Using system-wide rails"
  rails db:create db:migrate
fi

echo "Command received: $@"

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"