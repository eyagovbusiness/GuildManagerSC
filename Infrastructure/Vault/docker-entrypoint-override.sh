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
	wait_IsReady rabbitmq
	vault_init_rabbitmq
	wait_IsReady consul
	exec IsReadyServer.sh &
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