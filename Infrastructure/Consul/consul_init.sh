#!/usr/bin/dumb-init /bin/sh

set -e

# Infrastructure
consul services register -name=RabbitMQ -address=localhost
consul services register -name=SecretManager -address=http://localhost -port=8200

# Services
consul services register -name=MandrilAPI -address=http://localhost -port=7002

