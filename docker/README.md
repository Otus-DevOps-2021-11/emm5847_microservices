------------------------------------------------------------------------------------------
Домашнее задание MONITORING-1
------------------------------------------------------------------------------------------
1. В Prometheus добавлен мониторинг mongodb

   docker-compose.yml:

       mongodb-exporter:
         image: bitnami/mongodb-exporter
         command:
           - '--log.level=debug'
           - '--mongodb.uri=mongodb://mongo:27017'
           - '--collect-all'
         ports:
           - 9216:9216
         networks:
           - common_net

   prometheus.yml:

       - job_name: 'mongo'
         static_configs:
           - targets:
             - 'mongodb-exporter:9216'

2. В Prometheus добавлен мониторинг сервисов с помощью blackbox-exporter

   docker-compose.yml:

       blackbox-exporter:
         image:  amdocuser/blackbox-exporter
         command:
           - '--config.file=/config/blackbox.yml'
         ports:
           - 9115:9115
         networks:
           - common_net

   prometheus.yml
       - job_name: 'blackbox-http'
         metrics_path: /probe
         params:
           module: [http_2xx]
         static_configs:
           - targets:
             - http://ui:9292
             - http://comment:9292/healthcheck
             - http://post:5000/healthcheck
         relabel_configs:
           - source_labels: [__address__]
             target_label: __param_target
           - source_labels: [__param_target]
             target_label: instance
           - target_label: __address__
             replacement: blackbox-exporter:9115

       - job_name: 'blackbox-tcp'
         metrics_path: /probe
         params:
           module: [tcp_connect]
         static_configs:
           - targets:
             - mongo:27017
         relabel_configs:
           - source_labels: [__address__]
             target_label: __param_target
           - source_labels: [__param_target]
             target_label: instance
           - target_label: __address__
             replacement: blackbox-exporter:9115

3. Добавлен Makefile для автоматизации сборки образов


------------------------------------------------------------------------------------------
Домашнее задание DOCKER-4
------------------------------------------------------------------------------------------

1. Изменить docker-compose под кейс с множеством сетей, сетевых алиасов

В файле Docker-compose добавлены две сети front-net и back-net. Сервисы ui, post, comment включены
одновременно в две сети. Сервис post-db включен только в одну - front-net.

2. Параметризуйте с помощью переменных окружений:

Добавлен файл .env.example, в котором заданы переменные окружения.

3. Узнайте как образуется базовое имя проекта. Можно ли его задать?

Базовое имя берется из названия текущей директории. Его можно поменять с помощью "container_name" в секции сервиса


3. Создайте docker-compose.override.yml для reddit проекта

a)Изменены параметры сервисов без создания сборки образов

  post_db:
    environment:
      ENV_VALUE: "Hello"

  post:
    volumes:
      - post_db:${DB_PATH}

  comment:
    container_name: comment_app

б)Запуск puma в дебаг режиме с числом воркеров 2
  Добавим в docker-compose.override.yml

  version: '3.3'
  services:
    comment:
      command: puma --debug -w 2
    ui:
      command: puma --debug -w 2


------------------------------------------------------------------------------------------
Домашнее задание DOCKER-3
------------------------------------------------------------------------------------------

1. Изменены сетевые aliase контейнеров.

    Таблица переименования aliases:

    post_db -> post_db_host
    comment_db -> comment_db_host
    post -> post_host
    comment -> comment_host

    Команда запуска контейнеров выглядит так:

    docker run -d --network=reddit --network-alias=post_db_host --network-alias=comment_db_host mongo:latest
    docker run -d --network=reddit --network-alias=post_host amdocuser/post:1.0
    docker run -d --network=reddit --network-alias=comment_host amdocuser/comment:1.0
    docker run -d --network=reddit -p 9292:9292 amdocuser/ui:1.0

2. Сборка ui на основе Alpine.
   Изменения находятся в файле Dockerfile.ui, Gemfile.ui в папке src/ui

    Строки:

        FROM ruby:2.2
        RUN apt-get update -qq && apt-get install -y build-essential

    Заменены на:

        FROM ruby:2.2-alpine

        RUN apk add --no-cache --update build-base
        RUN gem install bundler -v "1.17.3" --no-document

    Размер образа заметно уменьшился:
        REPOSITORY          TAG            IMAGE ID       CREATED             SIZE
        amdocuser/ui        1.1            0b8e05ea3cdd   7 minutes ago       296MB
        amdocuser/ui        1.0            9191dffc1f32   About an hour ago   754MB

3. Сборка comment на основе Alpine.
   Изменения находятся в файле Dockerfile.comment, Gemfile.comment в папке src/comment

    Строки:

        FROM ruby:2.2
        RUN apt-get update -qq && apt-get install -y build-essential

    Заменены на:

        FROM ruby:2.2-alpine

        RUN apk add --no-cache --update build-base
        RUN gem install bundler -v "1.17.3" --no-document

    Размер образа заметно уменьшился:
        REPOSITORY               TAG            IMAGE ID       CREATED          SIZE
        amdocuser/comment-test   1.1            a8ef5044b9d0   9 minutes ago    294MB
        amdocuser/comment        1.0            6d559d374a28   2 days ago       769MB
