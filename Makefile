.PHONY: all build start stop

all: stop build start

build:
	./bin/build.sh

start:
	./bin/start.sh

stop:
	./bin/stop.sh

snapshot:
	./bin/snapshot.sh

status:
	./bin/status.sh