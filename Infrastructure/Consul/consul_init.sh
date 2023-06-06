#!/usr/bin/dumb-init /bin/sh

set -e

function consul_init_func(){
# Infrastructure
consul services register -name=RabbitMQ -address=rabbitmq
consul services register -name=VaultSecretsManager -address=http://vault -port=8200
consul services register -name=MySql -address=http://mysql -port=3306

# Services
consul services register -name=Mandril -address=http://mandril-ms -port=80
}


