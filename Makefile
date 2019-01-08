PACKAGE="hiracchi/sphinx"
TAG=latest
CONTAINER_NAME="sphinx"

.PHONY: build start stop restart term logs

build:
	docker build -t "${PACKAGE}:${TAG}" .


start:
	\$(eval USER_ID := $(shell id -u))
	\$(eval GROUP_ID := $(shell id -g))
	docker run -d \
		--rm \
		--name ${CONTAINER_NAME} \
		-u $(USER_ID):$(GROUP_ID) \
		--volume "${PWD}:/work" \
		"${PACKAGE}:${TAG}"
	#sleep 4
	docker ps -a

stop:
	docker rm -f ${CONTAINER_NAME}


restart: stop start


term:
	docker run -it \
		--rm \
		--name ${CONTAINER_NAME} \
		-u $(USER_ID):$(GROUP_ID) \
		--volume "${PWD}:/work" \
		"${PACKAGE}:${TAG}" \
		/bin/bash


logs:
	docker logs ${CONTAINER_NAME}
