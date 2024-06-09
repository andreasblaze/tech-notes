---
title: Troubleshooting
sidebar_position: 10
toc_min_heading_level: 2
toc_max_heading_level: 6
---

import TOCInline from '@theme/TOCInline';

<TOCInline toc={toc} minHeadingLevel={2} maxHeadingLevel={6} />

## curl
Используется для общей проверки доступности ресурса:
```bash
curl -v example.com
```
Если хотим проверить отдельный порт доменного имени:
```bash
curl -vvv whois.namecheap.com
```
Эта команда покажет заголовки HTTP, включая код состояния, который может указывать, доступна ли страница (например, HTTP/1.1 200 OK):
```bash
curl -I https://www.example.com
```
## nmap
nmap - To check which network ports are open on the server:
```bash
nmap -p 80,443 www.example.com
```
## telnet
Чтобы подключиться к веб-серверу через порт 443:
```bash
telnet www.example.com 443
```
## traceroute
```bash

```
## netcat
```bash
nc -w3 -4 -v www.redhat.com 80
```
## mtr
Например, чтобы проверить роутинг и качество соединения трафика с хостом назначения example.com:
```bash
mtr -rw example.com
```
Анализируя вывод MTR, вы ищете две вещи: потери и задержку:
```bash
mtr --report www.google.com
```
## nslookup
```bash

```
## dig
```bash
dig @8.8.8.8 +short TXT mailout.spacemail.com "v=spf1 include:spf-spacemail.jellyfish.systems -all"
```

## Networking Errors & solutions in Linux
### Connection Refused
Происходит, когда сервер активно отклоняет запрос на соединение.
- Причина: Возможно, служба не запущена или не настроена должным образом.
- Решение: Проверьте состояние службы и файлы конфигурации.
### Connection Timed Out
Указывает, что попытка подключения заняла слишком много времени.
- Причина: настройки фаервола, перегрузка сети или не отвечает сервер.
- Решение: проверьте правила фаервола, конфигурации сети и сервера.
ответная реакция.
### No Route to Host
Указывает на невозможность связаться с хостом назначения.
- Причина: неправильная таблица маршрутизации или неправильная конфигурация сети.
- Решение: проверьте таблицы маршрутизации с помощью `route` или `ip route`.
### Host Unreachable
Аналогично «Нет маршрута к хосту» означает невозможность добраться до места назначения.
- Причина: неправильная конфигурация сети или неправильный IP-адрес.
- Решение: проверьте конфигурацию IP и настройки сети.

## Ports
### Opening a Port
```bash
sudo ufw allow <port_number>
```
or
```bash
firewall-cmd --add-port=<port_number>/tcp
```
or
```bash
iptables -A INPUT -p tcp --dport <port_number> -j ACCEPT
```
### List All Open Ports
```bash
netstat -lntu
```
or
```bash
ss -lntu
```
-    all listening sockets (`-l`)
-    the port number (`-n`)
-    TCP ports (`-t`)
-    UDP ports (`-u`)
### Check Port
```bash
ls | nc -l -p <port_number>
```
or
```bash
telnet localhost <port_number>
```
or
```bash
nmap localhost -p <port_number>
```
### To Check The Availability of a Port on a Remote Server
```bash
cat < /dev/tcp/<server-ip-or-dns>/<port>
```
> Если порт открыт: команда подключится к `example.com` через порт `80` (порт HTTP). Если соединение успешное, оно будет ожидать ввода или вывода. При необходимости вы можете отправлять HTTP-запросы или другие данные.