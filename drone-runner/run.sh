#!/bin/bash

echo "Run services"

echo "Enter server name"
read -p "Server name: " server_name_var
export SERVER_ADDRESS=$server_name_var

echo "Enter Drone RPC secret key"
read -p "Drone secret key: " drone_rpc_secret_var
export DRONE_RPC_SECRET=$drone_rpc_secret_var

echo "Enter Drone runner name"
read -p "Drone runner name: " $drone_runner_name_var
export DRONE_RUNNER_NAME=$drone_runner_name_var

docker-compose -f docker-compose.yml up -d
