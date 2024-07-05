---
sidebar_position: 3
---

# CMD's

## Список запущенных контейнеров
```bash
docker ps
```

## Загрузка/выгрузка образа
```bash
docker pull/push
```

## Сборка образа из Dockerfile
```bash
docker build -t pdp:v1 .
```

## Смотрим логи указанного контейнера
```bash
docker logs -follow pdp
```

## Запуск контейнера на основе указанного образа
```bash
docker run pdp -d -it bash
```
> -d(detached) -it(interactive) bash

## Мягкая остановка контейнера
```bash
docker stop $(docker ps -a -q)
```

## Запуск уже существующего контейнера
```bash
docker start --attach -i mycontainer
```

## Завершение процесса контейнера
```bash
docker kill $(ps -a -q)
```

## Удаление контейнера
```bash
docker rm
```

## Удаление образа
```bash
docker rmi
```

## Показывает каждый слой образа в ретроспективе, отображая ряд полезных сведений
```bash
docker history
```

## Создает контейнер без его запуска
```bash
docker create -i -t --name mycontainer alpine
```

## Войти в контейнер и выполнить в нем команду
```bash
docker exec -d ubuntu_bash touch /tmp/execWorks
```

## Получить расширенную информацию о Docker
```bash
docker info
```

## Сохранить файл из контейнера в локальную систему
```bash
docker cp CONTAINER:/var/logs/ /tmp/app_logs
```

##
```bash
docker search --filter stars=3 busybox
```

## Удаляет все ненужные контейнеры
```bash
docker container prune
```

## 
```bash
docker login localhost:8080
```

## Запуск сервиса Docker (демона)
```bash
dockerd
```

## Создание нового образа из изменений в контейнере
```bash
commit
```

## 
```bash

```