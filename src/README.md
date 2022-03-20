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
