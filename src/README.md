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
