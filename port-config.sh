#!/bin/bash
# port-config.sh
PROJECT_NAME=$(basename "$PWD")
PORT_FILE="./.port"
# Check if there's already an allocated port
if [ -f "$PORT_FILE" ]; then
  PORT=$(cat "$PORT_FILE")
  echo "Using previously allocated port: $PORT"
else
  # Start looking for available ports from 3000
  PORT=3000
  
  # Check if the port is in use
  while netstat -tuln | grep -q ":$PORT "; do
    PORT=$((PORT + 1))
  done
  
  # Save port configuration
  echo $PORT > "$PORT_FILE"
  echo "Allocated new port: $PORT"
  
  # Update port in docker-compose.yml
  sed -i "s/- \"[0-9]*:3000\"/- \"$PORT:3000\"/" docker-compose.yml
  rm -f docker-compose.yml.bak
fi
echo "Project $PROJECT_NAME will use port: $PORT"
echo "PORT=$PORT" > .env
echo "Start command: docker-compose up -d"