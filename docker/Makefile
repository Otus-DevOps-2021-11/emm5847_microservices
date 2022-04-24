.PHONY: all comment ui post blackbox-exporter prometheus
all: comment ui post blackbox-exporter prometheus

comment:
	docker build -t ${DOCKER_USERNAME}/comment:latest comment/

ui:
	docker build -t ${DOCKER_USERNAME}/ui:latest ui/

post:
	docker build -t ${DOCKER_USERNAME}/post:latest post-py/

blackbox-exporter:
	docker build -t ${DOCKER_USERNAME}/blackbox-exporter blackbox/

prometheus:
	docker build -t ${DOCKER_USERNAME}/prometheus prometheus/

docker-login:
	docker login --username ${DOCKER_USERNAME} --password ${DOCKER_PASSWORD}

docker-push: docker-login
	docker image push ${DOCKER_USERNAME}/comment:latest
	docker image push ${DOCKER_USERNAME}/ui
	docker image push ${DOCKER_USERNAME}/post
	docker image push ${DOCKER_USERNAME}/blackbox-exporter
	docker image push ${DOCKER_USERNAME}/prometheus
