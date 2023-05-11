set -euo pipefail
#set -x

function rabbitmq_init_func(){
echo "RabbitMQ initialization script started."

if [ "$ASPNETCORE_ENVIRONMENT" = "Development" ]; then
	CreateUserEcho="*** Administrator user '$RABBITMQ_USER' with password '$RABBITMQ_PASSWORD' created successfully! ***"
else
	CreateUserEcho="Administrator user created successfully!" 
fi

# Create Rabbitmq user
rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD 
rabbitmqctl set_user_tags $RABBITMQ_USER administrator 
rabbitmqctl set_permissions -p / $RABBITMQ_USER  ".*" ".*" ".*" 
echo $CreateUserEcho
	
echo "RabbitMQ initialization script finished."
}
