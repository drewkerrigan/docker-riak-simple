#!/bin/bash

CONTAINER_ID=$(docker ps | egrep "drewkerrigan/riak-simple" | cut -d" " -f1)
CONTAINER_PORT=$(docker port "${CONTAINER_ID}" 8098 | cut -d ":" -f2)

if curl -s "http://localhost:${CONTAINER_PORT}/ping" | grep "OK" > /dev/null 2>&1;
then 
    echo; echo "   Riak is running at [http://localhost:${CONTAINER_PORT}]"; echo
else
    echo; echo "   Riak is not running"; echo
fi