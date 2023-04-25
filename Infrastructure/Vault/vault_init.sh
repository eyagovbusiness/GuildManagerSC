#!/usr/bin/dumb-init /bin/sh

set -e

echo "Vault initialization script started."

if [ "$ASPNETCORE_ENVIRONMENT" = "Development" ]; then
	RabbitMQEcho="RabbitMQ key-value created for username = '$RABBITMQ_USER' and password = '$RABBITMQ_PASSWORD'";
	MySqlEcho="MySql key-value created for username = '$MySql_USER' and password = '$MySql_PASSWORD'";
else
  	RabbitMQEcho="RabbitMQ key-value created for username and password";
	MySqlEcho="MySql key-value created for username and password"; 
fi

##KeyValue secrets:
##RabbitMQ
vault kv put secret/rabbitmq username=$RABBITMQ_USER password=$RABBITMQ_PASSWORD && echo $RabbitMQEcho
##MySql
vault kv put secret/mysql username=$MySql_USER password=$MySql_PASSWORD && echo $MySqlEcho

##Using the RabbitMQ integration with Vault.
vault secrets enable rabbitmq && echo "Vault integration with RabbitMQ enabled!"

(vault write rabbitmq/config/connection \
    connection_uri="http://rabbitmq:15672" \
    username=$RABBITMQ_USER \
    password=$RABBITMQ_PASSWORD ; \
echo "Vault integration with $RabbitMQEcho") &

vault write rabbitmq/roles/GuildManagerSC-role \
    vhosts='{"/":{"write": ".*", "read": ".*"}}'
echo "RabbitMQ role created."	

echo "Vault initialization script finished."