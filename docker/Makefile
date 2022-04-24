.PHONY: all comment ui post blackbox-exporter prometheus
all: comment ui post blackbox-exporter prometheus

comment:
	docker build -t amdocuser/comment:latest comment/

ui:
	docker build -t amdocuser/ui:latest ui/

post:
	docker build -t amdocuser/post:latest post-py/

blackbox-exporter:
	docker build -t amdocuser/blackbox-exporter blackbox/

prometheus:
	docker build -t amdocuser/prometheus prometheus/

docker-login:
	docker login --username ${DOCKER_USERNAME} --password ${DOCKER_PASSWORD}

docker-push: docker-login
	docker image push ${DOCKER_USERNAME}/comment:latest
	docker image push ${DOCKER_USERNAME}/ui
	docker image push ${DOCKER_USERNAME}/post
	docker image push ${DOCKER_USERNAME}/blackbox-exporter
	docker image push ${DOCKER_USERNAME}/prometheus
