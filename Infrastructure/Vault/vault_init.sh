#!/usr/bin/dumb-init /bin/sh

set -e

wait_for_rabbitmq() {
	counter=0
	while ! nc -z rabbitmq 5672 2>/dev/null || ! nc -z rabbitmq 15672 2>/dev/null; do
		echo "Waiting for RabbitMQ to start..."
		sleep 1
		counter=$((counter + 1))
		if [ $counter -eq 10 ]; then
			echo "Timed out waiting for RabbitMQ to start."
			exit 1
		fi
	done
	echo "RabbitMQ is running!"
	echo "Waiting 2 seconds to let RabbitMQ create the users after it started..."
	sleep 2
}

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
rabbitmq_result=$(vault secrets enable rabbitmq)
echo "Enable Vault integration with RabbitMQ => $rabbitmq_result"

wait_for_rabbitmq

rabbitmq_result=$(vault write rabbitmq/config/connection \
					connection_uri="http://rabbitmq:15672" \
					username=$RABBITMQ_USER \
					password=$RABBITMQ_PASSWORD)
echo "Create Vault connection with $RabbitMQEcho => $rabbitmq_result"

rabbitmq_result=$(vault write rabbitmq/roles/GuildManagerSC-role \
					vhosts='{"/":{"write": ".*", "read": ".*"}}')
echo "RabbitMQ role created => $rabbitmq_result"

echo "Vault initialization script finished."