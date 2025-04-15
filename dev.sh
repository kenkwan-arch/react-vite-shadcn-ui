#!/bin/bash
# dev.sh
# Configure running ports
sh ./port-config.sh
# Build and start containers
docker compose build
docker compose up -d
# Check if the container started successfully
CONTAINER_ID=$(docker compose ps -q app)
if [ -z "$CONTAINER_ID" ]; then
  echo "Container failed to start"
  exit 1
fi
echo "Container started, development server is running..."
# View application logs (optional)
docker compose logs -f app