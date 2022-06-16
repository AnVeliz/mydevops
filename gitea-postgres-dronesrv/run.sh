#!/bin/bash

echo "Run services"

echo "Enter server name"
read -p "Server name (e.g. git.myserver.com): " server_name_var
export SERVER_ADDRESS=$server_name_var

echo "Enter user name"
read -p "User name: " user_name_var
export USER_NAME=$user_name_var

echo "Enter password"
read -sp "Password: " user_password_var
export USER_PASSWORD=$user_password_var

docker-compose -f docker-compose.yml up -d gitea

echo "Open Gitea server in your browser and create OAuth token (e.g. drone:3001, http://"${SERVER_ADDRESS}":3001/login). After a first attempt of logging in with Drone, you may need to change the Redirect URI adding a trailing slash. Just play with trailing slash updating the URI and modifying the request in browser. Gitea is not really stable..."

echo "Enter Gitea client ID for the OAuth"
read -p "ClientID: " client_id_var
export DRONE_GITEA_CLIENT_ID=$client_id_var

echo "Enter Gitea client secret for the OAuth"
read -p "Client secret: " client_secret_var
export DRONE_GITEA_CLIENT_SECRET=$client_secret_var

echo "Running drone with ClientID: "${DRONE_GITEA_CLIENT_ID}
export DRONE_RPC_SECRET=987b9ae841bb1a0aac8b829c9ec38960
docker-compose -f docker-compose.yml up -d drone

echo "You may also want to redirect 80 to 3000 so that your Git server would be available without explicitly specifying the port rumber"
echo "iptables -t nat -A PREROUTING -i YOUR_INTERFACE_NAME -p tcp --dport YOUR_SOURCE_PORT_NUMBER -j REDIRECT --to-port YOUR_DESTINATION_PORT_NUMBER"
echo "To get it, please run the command above and replace YOUR_INTERFACE_NAME (e.g. eth0), YOUR_SOURCE_PORT_NUMBER (e.g. 80), YOUR_DESTINATION_PORT_NUMBER (e.g. 3000)"

echo "======================="
echo "Please update app.ini manually setting the allowed drone hosts for hooks"
echo "
[webhook]
ALLOWED_HOST_LIST = *
"