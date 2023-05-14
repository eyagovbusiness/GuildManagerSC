#!/usr/bin/dumb-init /bin/sh

set -e

function consul_init_func(){
# Infrastructure
consul services register -name=RabbitMQ -address=rabbitmq
consul services register -name=VaultSecretsManager -address=http://vault -port=8200

# Services
consul services register -name=MandrilAPI -address=http://MandrilAPI -port=7002
}


