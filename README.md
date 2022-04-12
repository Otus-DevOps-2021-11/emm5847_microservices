# emm5847_microservices
emm5847 microservices repository

1. Автоматизация развёртывания GitLab
   Добавлены плейбуки gitlab-ci/install_docker.yml и gitlab-ci/run_docker_gitlab.yml для автоматической установки docker engine,
   docker-compose и gitlab

2. Запуск реддит в контейнере.
   В .gitlab-ci.yml.test добавлена строка по запуску контейнера reddit

   services:
     - amdocuser/otus-reddit:1.0

3. Автоматизация развёртывания GitLab Runner
   Добавлен gitlab-ci/docker-compose-runner.yml для запуска Gitlab Runner

4. Настройка оповещений в Slack
   Оповещение настроены на канал в slak - https://devops-team-otus.slack.com/archives/C02S04EHQNL
