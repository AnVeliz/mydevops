#!/bin/bash

echo "Run services"

echo "Enter server name"
read -p "Server name: " server_name_var
export SERVER_ADDRESS=$server_name_var

echo "Enter user name"
read -p "User name: " user_name_var
export USER_NAME=$user_name_var

echo "Enter password"
read -sp "Password: " user_password_var
export USER_PASSWORD=$user_password_var

docker-compose -f docker-compose.yml up -d gitea

echo "Open Gitea server in your browser and create OAuth token (e.g. drone, http://"${SERVER_ADDRESS}":3001/login/)"

echo "Enter Gitea client ID for the OAuth"
read -p "ClientID: " client_id_var
export DRONE_GITEA_CLIENT_ID=$client_id_var

echo "Enter Gitea client secret for the OAuth"
read -p "Client secret: " client_secret_var
export DRONE_GITEA_CLIENT_SECRET=$client_secret_var


echo "Running drone with ClientID: "${DRONE_GITEA_CLIENT_ID}
export DRONE_RPC_SECRET=987b9ae841bb1a0aac8b829c9ec38960
docker-compose -f docker-compose.yml up -d drone
