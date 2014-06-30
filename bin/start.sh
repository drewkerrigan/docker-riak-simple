#! /bin/bash

if docker ps -a | grep "drewkerrigan/basho-bench" >/dev/null; then
  echo ""
  echo "It looks like you already have some Riak containers running."
  echo "Please take them down before attempting to bring up another"
  echo "cluster with the following command:"
  echo ""
  echo "  make stop"
  echo "    or"
  echo "  make stop-docker-riak-simple"
  echo ""

  exit 1
fi

echo
echo "Bringing up riak node:"
echo

docker run -P --name "riak" -d drewkerrigan/basho-bench > /dev/null 2>&1

CONTAINER_ID=$(docker ps | egrep "drewkerrigan/basho-bench" | cut -d" " -f1)
CONTAINER_PORT=$(docker port "${CONTAINER_ID}" 8098 | cut -d ":" -f2)

echo "Attepmting to contact http://localhost:${CONTAINER_PORT}/ping"

until curl -s "http://localhost:${CONTAINER_PORT}/ping" | grep "OK" > /dev/null 2>&1;
do
	echo "Retrying..."
	sleep 3
done

echo "  Successfully brought up Riak (http://localhost:${CONTAINER_PORT})"

echo
echo "Please wait approximately 30 seconds for riak to stabilize."
echo
