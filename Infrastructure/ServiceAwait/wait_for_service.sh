#!/usr/bin/dumb-init /bin/sh
# wait-for-it.sh: Wait for a service to become available

set -e

wait_for() {
  set -e
  local host="$1"
  local port="$2"
  #local cmd="$2"

  t=0
  until nc -z "$host" "$port" >/dev/null 2>&1 || [ $((t++)) -gt 20 ]; do
    >&2 echo "Service not available at $host:$port. Retrying in 2 seconds..."
    sleep 2
  done

  if [ "$t" -gt 30 ]; then
    >&2 echo "Error: Service not available after 30 retries every 2 seconds. Exiting..."
    exit 1
  else
    >&2 echo "Service is available at $host:$port"
    #exec ${cmd}
  fi
}
