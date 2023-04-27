#!/usr/bin/env bash
set -euo pipefail

execute_before_start() {
    echo "Executing scheduled tasks before the base entrypoint starts.."
	echo "DONE."
}

execute_after_start() {
	sleep 2 #need to wait to let the original entrypoint to create the needed files and folders.
	echo "Executing scheduled tasks after the base entrypoint exited.."
	exec rabbitmq_init.sh &
	daemon_init_pid=$!
	wait $daemon_init_pid
	echo "DONE."
}

echo "Starting entrypoint override" 
execute_before_start
echo "CALLING BASE ENTRYPOINT WITH CMD: $@"
exec docker-entrypoint.sh "$@" &
daemon_pid=$!
execute_after_start
wait $daemon_pid
echo "Entrypoint override exited"
