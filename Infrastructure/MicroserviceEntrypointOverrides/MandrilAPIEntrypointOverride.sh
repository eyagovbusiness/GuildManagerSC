set -e
#set -x
source wait_for_service.sh

execute_before_start() {
    echo "Executing scheduled tasks before the base entrypoint starts.."
	wait_for consul 8500	
	wait_for vault 8200	
	echo "Scheduled tasks before the base entrypoint starts..DONE."
}

echo "Starting entrypoint override" 
execute_before_start

echo "Calling base Entrypoint"
dotnet MandrilAPI.dll
echo "Entrypoint override exited" 