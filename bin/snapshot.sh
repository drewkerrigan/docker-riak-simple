#! /bin/bash

echo
echo "Creating Snapshot of current container"
echo

CONTAINER_ID=$(docker ps | egrep "drewkerrigan/riak-simple" | cut -d" " -f1)

docker commit ${CONTAINER_ID} riak_snapshot

echo
echo "Running /bin/bash on the snapshot"
echo

docker run -t -i riak_snapshot /bin/bash