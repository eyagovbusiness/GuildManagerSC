#!/usr/bin/dumb-init /bin/sh

set -e
#set -x
source vault_init.sh
source wait_for_service.sh

execute_before_start() {
    echo "Executing scheduled tasks before the base entrypoint starts.."	
	echo "Scheduled tasks before the base entrypoint starts..DONE."
}

execute_after_start() {
	echo "Executing scheduled tasks after the base entrypoint exited.."
	wait_for vault 8200
	vault_init_kv
	wait_for rabbitmq 15672 
	sleep 5 #needs to give time to rabbitmq_init to create and configure the user.
	vault_init_rabbitmq
	echo "Scheduled tasks after the base entrypoint exited..DONE."
}

echo "Starting entrypoint override" 
#execute_before_start

echo "CALLING BASE ENTRYPOINT WITH CMD: $@"
exec docker-entrypoint.sh "$@" &
daemon_pid=$!

execute_after_start
wait $daemon_pid
echo "Entrypoint override exited" 