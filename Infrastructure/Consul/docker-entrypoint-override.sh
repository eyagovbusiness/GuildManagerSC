#!/usr/bin/dumb-init /bin/sh

set -e
source wait_for_service.sh
source consul_init.sh

execute_before_start() {
    echo "Executing scheduled tasks before the base entrypoint starts.."
	echo "DONE."
}

execute_after_start() {
	echo "Executing scheduled tasks after the base entrypoint exited.."
	wait_for consul 8500
	consul_init_func
	exec IsReadyServer.sh &
	echo "Scheduled tasks after the base entrypoint exited..DONE."
}

echo "Starting entrypoint override" 
#execute_before_start
echo "CALLING BASE ENTRYPOINT WITH CMD: $@"
exec /usr/local/bin/docker-entrypoint.sh "$@" &
daemon_pid=$!
execute_after_start
wait $daemon_pid
echo "Entrypoint override exited" 