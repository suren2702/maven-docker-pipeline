#!/bin/bash

# Start applicative containers
PORT=$1 docker-compose up -d

# Wait for application to startup
count=0
until $(curl --output /dev/null --silent --head --fail http://localhost:8080/health) || ((count == 30)); do
   printf '.'
   ((count++))
   sleep 1
done
