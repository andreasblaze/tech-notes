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