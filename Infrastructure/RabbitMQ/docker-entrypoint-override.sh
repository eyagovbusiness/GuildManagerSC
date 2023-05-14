#!/usr/bin/env bash
set -euo pipefail
# set -x

source rabbitmq_init.sh
source wait_for_service.sh

execute_before_start() {
    echo "Executing scheduled tasks before the base entrypoint starts.."
	echo "DONE."
}

execute_after_start() {
	echo "Executing scheduled tasks after the base entrypoint exited.."
	wait_for rabbitmq 15672 
	rabbitmq_init_func
	exec IsReadyServer.sh &
	echo "Scheduled tasks after the base entrypoint exited..DONE."
}

echo "Starting entrypoint override" 
execute_before_start

echo "CALLING BASE ENTRYPOINT WITH CMD: $@"
exec docker-entrypoint.sh "$@" &
daemon_pid=$!

execute_after_start
wait $daemon_pid
echo "Entrypoint override exited"
