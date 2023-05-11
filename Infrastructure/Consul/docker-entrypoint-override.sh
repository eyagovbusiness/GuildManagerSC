#!/usr/bin/dumb-init /bin/sh

set -e

execute_before_start() {
    echo "Executing scheduled tasks before the base entrypoint starts.."
	echo "DONE."
}

execute_after_start() {
    sleep 1
	echo "Executing scheduled tasks after the base entrypoint exited.."
	daemon_init_pid=$!
	exec consul_init.sh &
	wait $daemon_init_pid
	echo "DONE."
}

echo "Starting entrypoint override" 
#execute_before_start
echo "CALLING BASE ENTRYPOINT WITH CMD: $@"
exec /usr/local/bin/docker-entrypoint.sh "$@" &
daemon_pid=$!
execute_after_start
wait $daemon_pid
echo "Entrypoint override exited" 