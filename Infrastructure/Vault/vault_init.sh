
function vault_init_kv(){
echo "Vault initialization script started."

if [ "$ASPNETCORE_ENVIRONMENT" = "Development" ]; then
	MySqlEcho="MySql key-value created for username = '$MySql_USER' and password = '$MySql_PASSWORD'";
else
	MySqlEcho="MySql key-value created for username and password"; 
fi

##KeyValue secrets:
##RabbitMQ
vault kv put secret/rabbitmq username=$RABBITMQ_USER password=$RABBITMQ_PASSWORD && echo $RabbitMQEcho
##MySql
vault kv put secret/mysql username=$MYSQL_USER password=$MYSQL_PASSWORD && echo $MySqlEcho
##DiscordBot
vault kv put secret/mandrilbot MandrilBotToken=$MandrilBot_TOKEN DiscordTargetGuildId=$MandrilBot_GUILD_ID && echo "mandrilbot secrets were set!"
##API authentication secret token
vault kv put secret/apisecrets SecretKey=$API_PRIV_KEY && echo "API authentication secret token was set!"
}

function vault_init_rabbitmq(){
echo "Vault integration with RabbitMQ initialization started."

if [ "$ASPNETCORE_ENVIRONMENT" = "Development" ]; then
	RabbitMQEcho="RabbitMQ key-value created for username = '$RABBITMQ_USER' and password = '$RABBITMQ_PASSWORD'";
else
  	RabbitMQEcho="RabbitMQ key-value created for username and password";
fi

##Using the RabbitMQ integration with Vault.
rabbitmq_result=$(vault secrets enable rabbitmq)
echo "Enable Vault integration with RabbitMQ => $rabbitmq_result"

rabbitmq_result=$(vault write rabbitmq/config/connection \
					connection_uri="http://rabbitmq:15672" \
					username=$RABBITMQ_USER \
					password=$RABBITMQ_PASSWORD)
echo "Create Vault connection with $RabbitMQEcho => $rabbitmq_result"

rabbitmq_result=$(vault write rabbitmq/roles/GuildManagerSC-role \
					vhosts='{"/":{"write": ".*", "read": ".*"}}')
echo "RabbitMQ role created => $rabbitmq_result"

echo "Vault integration with RabbitMQ initialization finished."
}

