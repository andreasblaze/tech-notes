---
sidebar_position: 4
---

# Deploy with compose
Docker Compose — это инструмент для определения и запуска многоконтейнерных приложений Docker. С Compose вы используете файл YAML для настройки служб, сетей и томов вашего приложения. Затем с помощью одной команды вы создаете и запускаете все компоненты из вашей конфигурации.

*docker-compose.yml*:
```yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    networks:
      - webnet
  database:
    image: postgres:latest
    environment:
      POSTGRES_DB: exampledb
      POSTGRES_USER: exampleuser
      POSTGRES_PASSWORD: examplepass
    volumes:
      - db-data:/var/lib/postgresql/data
    networks:
      - webnet

volumes:
  db-data:

networks:
  webnet:
```
- **Services**: Определены две службы, веб-служба с использованием образа nginx и база данных с использованием образа postgres.
- **Ports**: веб-служба открывает порт 80 на хосте и перенаправляет на порт 80 на контейнере.
- **Environment Variables**: служба базы данных имеет переменные среды, установленные для настройки сервера PostgreSQL.
- **Volumes**: Данные для базы данных PostgreSQL сохраняются в именованном томе (db-data).
- **Networks**: обе службы подключены к сети с именем webnet.

## CMD's

```bash
# This command will pull the required Docker images, start the services defined in your docker-compose.yml file, and create the networks and volumes as specified.
docker-compose up        

docker-compose up -d     # To run in detached mode (in the background)
docker-compose stop      # Stopping Services: To stop the services without removing them
docker-compose start     # Starting Services: To start services that were previously stopped
docker-compose down      # Removing Services: To stop and remove containers, networks, and volumes created by up
docker-compose logs      # To view logs for running services
```

https://github.com/mukovoz/youtube-elk/blob/main/docker-compose.yaml
```yaml
services:
  php:
    container_name: "elk-php"
    build:  
      context: ./config/php
    volumes:
      - "./src:/var/www/html"
      - "./logs/debug.log:/var/www/debug.log"
    expose:
      - 9000
    environment:
      WEBROOT: "/var/www/html"
      XDEBUG_MODE: "debug"
    networks:
      - elastic
  nginx:
    image: nginx:latest
    volumes:
      - "./config/nginx/default.vhosts.conf:/etc/nginx/conf.d/default.conf"
      - "./src:/var/www/html"
      - "./logs/access.log:/var/log/nginx/access.log"
    ports:
      - "80:80"
    networks:
      - elastic
  elasticsearch:
    image: elasticsearch:7.16.1
    container_name: es
    environment:
      discovery.type: single-node
      ES_JAVA_OPTS: "-Xms512m -Xmx512m"
      http.host: 0.0.0.0
      http.port: 9200
      http.cors.allow-origin: http://localhost:8081
      http.cors.enabled: true
      http.cors.allow-headers: X-Requested-With,X-Auth-Token,Content-Type,Content-Length,Authorization"
      http.cors.allow-credentials: true
    ports:
      - "9200:9200"
      - "9300:9300"
    healthcheck:
      test: ["CMD-SHELL", "curl --silent --fail localhost:9200/_cluster/health || exit 1"]
      interval: 10s
      timeout: 10s
      retries: 3
    networks:
      - elastic
  logstash:
    image: logstash:7.16.1
    container_name: logstash
    environment:
      discovery.seed_hosts: logstash
      LS_JAVA_OPTS: "-Xms512m -Xmx512m"
    volumes:
      - ./config/logstash/pipeline/:/usr/share/logstash/pipeline/
      - ./config/logstash/pipelines.yml:/usr/share/logstash/config/pipelines.yml
      - ./logs/access.log:/home/access.log
      - ./logs/debug.log:/home/debug.log
    ports:
      - "5000:5000/tcp"
      - "5000:5000/udp"
      - "5044:5044"
      - "5043:5043"
      - "9600:9600"
    expose:
      - 5043
    depends_on:
      - elasticsearch
    networks:
      - elastic
    command: logstash  
  kibana:
    image: kibana:7.16.1
    container_name: kib
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch
    networks:
      - elastic
networks:
  elastic:
    driver: bridge
```