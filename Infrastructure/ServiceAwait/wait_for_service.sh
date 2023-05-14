#!/usr/bin/dumb-init /bin/sh
#This script offers functions to facilitate waiting for a service to become available.

set -e
# set -x

#Args: host, port, retries(optional)
#This function awaits until the provided host service from the first argument is running on the specified port
#This function can be used during a container entrypoint to wait until a certain service(local or forom another container) is up.
wait_for() {
  local host="$1"
  local port="$2"
  local retries="${3:-30}"
  #local cmd="$2"

  count=0
  echo "Waiting for $host service to be available at $host:$port..."
  until nc -z "$host" "$port" >/dev/null 2>&1 || [ $((count++)) -gt $retries ]; do
    sleep 2
  done

  if [ "$count" -gt $retries ]; then
    echo "Error: $host service was not available after $retries every 2 seconds. Exiting..."
    exit 1
  else
    echo "$host service is available at $host:$port"
    #exec ${cmd}
  fi
}

#Args: host, port(optional), retries(optional)
#This function awaits until the provided host service from the first argument runs the IsReadyServer.sh script on the specified port.
#This function can be called during a container entrypoint that depends on another container to wait for it being ready before continuing with the entrypoint execution.
wait_IsReady() {
	local host="$1"
	local port="${2:-8000}"
	local retries="${3:-30}"
	echo "Waiting for $host service to be ready..."
	RESPONSE=""
	count=0
	
	while [[ "$RESPONSE" != *"READY"* ]]; do
	  RESPONSE=$(nc "$host" "$port" || true)
	  sleep 2
	  count=$((count+1))
	  if [[ $count -ge $retries ]]; then
	    echo "Error: $host service is not ready after $count retries"
	    exit 1
	  fi
	done
	# echo "READY response recieved from $host Response: $RESPONSE"
	echo "$host service is ready!!"
}


