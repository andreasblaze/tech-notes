---
sidebar_position: 4
---

# CMD's

## Перенаправление вывода/ввода

1. **< file**: Используйте `file` в качестве источника стандартного ввода.
   ```bash
   sort < unsorted.txt
   ```
   Эта команда отсортирует содержимое `unsorted.txt`.

2. **> file**: Прямой стандартный вывод в `file`. Создайте файл, если он не существует, или перезапишите его, если он существует.
   ```bash
   echo "Hello, Linux!" > greetings.txt
   ```
   Это напишет "Hello, Linux!" в `greetings.txt`, перезаписать любой существующий контент.

3. **2> file**: Направьте стандартную ошибку на `file`. Создайте файл, если он не существует, или перезапишите его, если он существует.
   ```bash
   grep "pattern" missingfile.txt 2> errors.txt
   ```
   Это попытка найти "pattern" в `missingfile.txt` и записывает все сообщения об ошибках в `errors.txt`.

4. **>> file**: Добавить стандартный вывод в `file`. Создайте файл, если он не существует, или добавьте к нему, если он существует.
   ```bash
   echo "Welcome back!" >> greetings.txt
   ```
   Это добавит "Welcome back!" в конец `greetings.txt` без перезаписи существующего контента.

5. **2>> file**: Добавить стандартную ошибку к `file`. Создайте файл, если он не существует, или добавьте к нему, если он существует.
   ```bash
   grep "pattern" missingfile.txt 2>> errors.txt
   ```
   Это попытка найти "pattern" в `missingfile.txt` еще раз и добавляет все сообщения об ошибках в `errors.txt`.

6. **&> file** or **>& file**: Перенаправьте стандартный вывод и стандартную ошибку на `file`.
   ```bash
   ls -l /nonexistentdirectory &> output.txt
   ```
   Both the output (if any) and the error message from listing `/nonexistentdirectory` will be written to `output.txt`.

   Или используя другие обозначения:
   ```bash
   ls -l /nonexistentdirectory > output.txt 2>&1
   ```
   Это делает то же самое, что и предыдущая команда, но для достижения перенаправления используется другой синтаксис.

## Logs
```bash
tail -f /var/log/grafana/grafana.log | grep 'lvl=eror'
```
```bash
tail -f /var/log/messages | grep jenkins
```

## Files
### find
```bash
find / -name prometheus.yml
```
```bash
find / -type d -name 'workers'

/ - искать по всей системе, то есть начинать с точки монтирования "/"

-type d - искать только папки

-name 'workers' - в данном случае точное совпадение с workers
```
```bash
find / -type f -name '*_workers.rb'

/ - искать по всей системе, то есть начинать с точки монтирования "/"

-type f - искать только файлы

-name '*_workers.rb' - в данном случае все, что заканчивается на "_workers.rb"
```
### more
```bash

```
```bash

```
```bash

```
### less
```bash

```
```bash

```
```bash

```
### cp
```bash

```
```bash

```
```bash

```
### mv
```bash

```
```bash

```
```bash

```
### rm
```bash

```
```bash

```
```bash

```
### ln
```bash

```
```bash

```
```bash

```
### wc
```bash

```
```bash

```
```bash

```
### sort
```bash

```
```bash

```
```bash

```
### cut
```bash

```
```bash

```
```bash

```
### grep
```bash

```
```bash

```
```bash

```
### tar
```bash

```

## Simple Network Management Protocol (SNMP)
```bash
snmpwalk -v3 -u ncread -l authNoPriv -a MD5 -A {Authentication passphras} {mx...host}
```
## SELinux
### Мне нужно временно отключить **SELinux** на моих хостах Linux. Как мне это сделать?
```bash
sudo setenforce 0
sestatus
// Текущий режим SELinux установлен на «permissive», что означает, что он временно отключен. 
// Он регистрирует нарушения политики, но не обеспечивает их соблюдение.
```
## Network
### host
Отдает IP адрес хоста
```bash
host namecheap.com
```

### ping
Эхо-запрос: он отправляет пакеты эхо-запроса ICMP на целевой хост.
```bash
ping -c 4 -i 1 -s 100 www.example.com
```
>Эта команда отправляет 4 пакета эхо-запроса  Internet Control Message Protocol (ICMP) на сайт www.example.com с интервалом в 1 секунду между каждым пакетом, причем каждый пакет имеет размер 100 байт.

### traceroute (Linux) / tracert (Windows)
traceroute работает путем отправки пакетов  Internet Control Message Protocol (ICMP), и каждый маршрутизатор, участвующий в передаче данных, получает эти пакеты. Пакеты ICMP предоставляют информацию о том, способны ли маршрутизаторы, используемые при передаче, эффективно передавать данные.
- В крайнем левом столбце указан номер прыжка (hop);
- Следующие три столбца показывают время, необходимое для ответа от каждого перехода, измеренное в миллисекундах (мс). Для каждого хопа предоставляются три измерения, которые представляют время прохождения туда и обратно для каждого отправленного пробного пакета;
- В последнем столбце показан IP-адрес узла и, если доступно, имя хоста. В случаях, когда имя хоста не разрешено, отображается только IP-адрес.
```bash
traceroute -n -m 15 -q 1 www.example.com
```
>Эта команда отслеживает маршрут до www.example.com без выполнения поиска DNS (-n), с максимальным количеством прыжков (hops) 15 (-m 15) и отправкой только одного запроса на каждый переход (hop) (-q 1).

### nslookup / dig
DNS lookups
```bash
dig www.namecheap.com

; <<>> DiG 9.11.9 <<>> www.namecheap.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 10835
;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;www.namecheap.com.             IN      A

;; ANSWER SECTION:
www.namecheap.com.      300     IN      CNAME   www.namecheap.com.cdn.cloudflare.net.
www.namecheap.com.cdn.cloudflare.net. 300 IN A  104.16.100.56
www.namecheap.com.cdn.cloudflare.net. 300 IN A  104.16.99.56

;; Query time: 9 msec
;; SERVER: 192.168.0.1#53(192.168.0.1)
;; WHEN: Tue Feb 27 04:18:25 FLEST 2024
;; MSG SIZE  rcvd: 128
```
### 
```bash
nslookup www.namecheap.com
Server:         10.32.60.20
Address:        10.32.60.20#53

Non-authoritative answer:
www.namecheap.com       canonical name = www.namecheap.com.cdn.cloudflare.net.
Name:   www.namecheap.com.cdn.cloudflare.net
Address: 104.16.100.56
Name:   www.namecheap.com.cdn.cloudflare.net
Address: 104.16.99.56
```
```bash

```
```bash

```
### curl
Опция `curl -k` используется, чтобы указать Curl игнорировать проверку сертификата SSL при отправке запроса на сайт HTTPS. `-k` означает `--insecure`. По умолчанию Curl пытается проверить подлинность сертификата SSL, предоставленного сервером. Это гарантирует, что соединение безопасно и сервер соответствует тому, за что себя выдает.
```bash
curl -k https://www.namecheap.com --connect-timeout 10
```
Использование `-I` — это быстрый способ проверить headers в целях отладки, проверить конфигурацию веб-серверов, проверить наличие redirects, просмотреть заголовки кэширования и типы серверов, а также просмотреть другую информацию, которая может повлиять на способ доступа к веб-ресурсам и хранится. Это также распространенный инструмент в веб-разработке и системном администрировании для тестирования и устранения неполадок конфигураций HTTP-сервера.
>curl sends an HTTP HEAD request to the server. This request is similar to a GET request, but it tells the server that the client only wants the headers, not the actual content.
```bash
 curl -I https://www.namecheap.com/
HTTP/1.1 200 OK
Date: Tue, 27 Feb 2024 03:00:07 GMT
Content-Type: text/html; charset=UTF-8
Connection: keep-alive
CF-Ray: 85bd2cfd5f522dea-KBP
CF-Cache-Status: HIT
Age: 40
Cache-Control: public, max-age=14400
Expires: Tue, 27 Feb 2024 07:00:07 GMT
Last-Modified: Tue, 27 Feb 2024 02:56:27 GMT
Set-Cookie: x-ab-promoted-home-different-content=0;expires=Thu, 28 Mar 2024 03:00:07 GMT
Strict-Transport-Security: max-age=16000000; includeSubDomains
Vary: Accept-Encoding
x-frame-options: SAMEORIGIN
x-xss-protection: 1; mode=block
Set-Cookie: __cfruid=8e3da9a97d04367f92ae40215f8f8809d1374da3-1709002807; path=/; domain=.namecheap.com; HttpOnly; Secure; SameSite=None
Server: cloudflare
```
```bash
curl myip.wtf/text
```
>Узнать Public IP

### ip
```bash

```

### netstat
```bash

```

### wget
```bash

```

## Permissions
### chmod
```bash
chmod 
```
### chown
```bash
chown 
```
### chgrp
```bash
chgrp
```
### usermod 
```bash
usermod -aG docker jenkins
// Allow Jenkins users to access the docker socket
```
### set
```bash
set +x -eo pipefail node /usr/app/tfrunner/tfrunner.js apply -parallelism=10 tfplan_c357197a7543 2>&1 | tee 1b4e61512783.log
```

```bash

```

```bash

```

```bash

```

```bash

```
## Process management:

### &&
```bash

```

### kill
```bash

```

### ps
```bash

```

## System control:

### poweroff
```bash

```

### restart
```bash

```

## User management:

### whoami
```bash

```

## Creating and exporting environment variables:

### env
```bash

```

### export
```bash

```

### printenv
```bash

```

### source
```bash

```

## Application and process management:

### which
```bash

```

### yum
```bash

```

## Console and output management, working with data sent to stdout or displayed in a terminal window:

### cat
```bash

```

### clear
```bash

```

### echo
```bash

```

### top
```bash

```

## Troubleshooting