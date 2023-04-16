#!/bin/sh

echo "RabbitMQ initialization script started."

if [ "$ASPNETCORE_ENVIRONMENT" = "Development" ]; then
	CreateUserEcho="*** Administrator user '$RABBITMQ_USER' with password '$RABBITMQ_PASSWORD' created successfully! ***"
else
	CreateUserEcho="Administrator user created successfully!" 
fi

# Create Rabbitmq user
( rabbitmqctl wait --timeout 60 $RABBITMQ_PID_FILE ; \
rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD 2>/dev/null ; \
rabbitmqctl set_user_tags $RABBITMQ_USER administrator ; \
rabbitmqctl set_permissions -p / $RABBITMQ_USER  ".*" ".*" ".*" ; \
echo $CreateUserEcho ) &

# $@ is used to pass arguments to the rabbitmq-server command.
# For example if you use it like this: docker run -d rabbitmq arg1 arg2,
# it will be as you run in the container rabbitmq-server arg1 arg2
rabbitmq-server $@

echo "RabbitMQ initialization script finished."