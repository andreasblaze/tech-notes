---
sidebar_position: 4
---
# What happens when you type google.com in your browser and press Enter?
Как только нажимается Enter, браузер распознает «google.com» как доменное имя и попытается сопоставить его с правильным сервером, чтобы предоставить правильный контент.
## DNS Lookup
Компьютеры используют IP-адреса для идентификации, каждый узел в интернете имеет свой IP-адрес. Поэтому после нажатия Enter первым шагом будет преобразование текста в IP-адрес. Этот шаг имеет последовательную процедуру:
1. Браузер просматривает свой кеш, чтобы увидеть, есть ли в нем запись, соответствующая `Domain Name = IP-address`. Если запись есть, браузер использует IP-адрес для отправки запроса на сервер. Если в браузере нет записи, он перенаправляет поиск в `OS` компьютера;
2. Если `OS` не имеет записи в своем кеше, она пересылает запрос `Resolver`;
3. Резолвером обычно является `ISP` (*Internet Service Provider*). Все резолверы знают, где они могут найти корневой сервер. Если резолвер не имеет записи в своем кэше, он пересылает запрос разрешения на `Root Server`;
4. Корневой сервер — это один из 13 авторитетных `Name Servers`, которые отвечают на DNS-запросы, направляя резолвер на соответствующий `TLD` - *Top Level Domain*. Original top-level domains: .com (commercial), .org (organization), .net (network), .int (international), .edu (education), .gov, .mil. 
Затем резолвер сохраняет IP-адрес соответствующего TLD, которым в нашем случае является TLD «.com», предоставленный корневым сервером;
5. На этом этапе `resolver` пересылает `DNS resolution request` на сервер `TLD`. В ответ сервер TLD предоставляет IP-адреса авторитетных `Name Servers`;
6. Затем `Name Servers` передают IP-адрес DNS-запроса. Резолвер сохраняет эту информацию в своем кэше для дальнейшего использования;
7. Затем `resolver` отвечает на запрос `OS`, пересылая ответ браузеру;
8. `OS` и `Browser` кэшируют эту ^ информацию, чтобы ускорить обработку будущих запросов. TTL (Time To Live - время жизни) — продолжительность времени, в течение которого DNS-запись может быть кэширована, настраивается владельцем домена или определяется авторитетными `Name Servers`.
## TCP/IP
Теперь, когда у браузера есть IP-адрес, он должен создать соединение с сервером, которое соответствует IP-адресу, чтобы облегчить связь и обмен данными. Существуют различные протоколы, облегчающие передачу и обработку данных в Интернете. Однако большинство HTTP-запросов используют `TCP`.
> **TCP** (*Transmission Control Protocol* - протокол управления передачей) обеспечивает надежную и упорядоченную передачу данных между устройствами посредством пакетов данных. Пакеты данных представляют собой меньшие по размеру блоки данных, которые легче передавать и обрабатывать. TCP очень предпочтителен для HTTP-запросов, поскольку он имеет дополнительные функции, такие как управление потоком, обнаружение ошибок и повторная передача потерянных пакетов.

> **IP** (*Интернет-протокол*) отвечает за присвоение уникального адреса каждому устройству в Интернете для облегчения идентификации. Это также обеспечивает инкапсуляцию, адресацию и правильную маршрутизацию пакетов по сетям.

Соединение **TCP/IP** устанавливается в результате трехэтапного рукопожатия (handshake):
### SYN(Synchronize)
Ваш компьютер, который является клиентским компьютером, отправляет на сервер пакет, содержащий порядковый номер. Этот шаг указывает на намерение клиентского компьютера установить соединение.
### SYN-ACK(Synchronize-Acknowledge)
Получив пакет `SYN`, сервер проверяет, есть ли у него открытые порты для приема и инициирования новых соединений. Если есть открытые порты, он отвечает пакетом `SYN-ACK`. Этот пакет состоит из двух важных частей. Сначала он подтверждает получение пакета `SYN`, подтверждая порядковый номер. Во-вторых, сервер включает свой порядковый номер, чтобы обозначить свою готовность установить соединение.
### ACK(Acknowledgement)
После получения пакета `SYN-ACK` клиентский компьютер отвечает пакетом `ACK`. Этот пакет подтверждает получение пакета `SYN-ACK` и подтверждает порядковый номер сервера.

После трехстороннего рукопожатия соединение устанавливается, и устройства могут надежно обмениваться данными.

На этом этапе браузер отправляет запрос `GET` с запросом веб-страницы google.com через установленное `TCP-соединение`. Сервер получает запрос и отправляет в ответ `HTML-код` домашней страницы google.com. Браузер отобразит скелет HTML, и если веб-странице требуются дополнительные ресурсы, браузер отправит дополнительные запросы. Эти дополнительные запросы могут относиться к таким элементам, как изображения, файлы Javascript и таблицы стилей CSS.
## Firewall
Firewall может представлять собой физическое устройство или программное обеспечение, которое действует как барьер между внутренней и внешней сетью. Firewalls отслеживают и контролируют входящий и исходящий сетевой трафик на основе заранее определенных правил безопасности. При этом они защищают сеть от потенциальных угроз и несанкционированного доступа.
Firewalls проверяют сетевые пакеты и применяют предопределенные правила, чтобы определить, разрешать или блокировать их. Эти правила безопасности основаны на различных критериях, таких как:
- Source and destination IP address;
- Port numbers;
- Характеристики содержимого пакета.
## HTTPS/SSL
**HTTP** (*Hypertext Transfer Protocol*) — это протокол, используемый для передачи данных через Интернет. Он обрабатывает связь между браузером и сервером в форме `request` и `response`. Как следует из названия, **HTTPS** (*Hypertext Transfer Protocol Secure*) представляет собой безопасную версию HTTP. Под безопасностью мы подразумеваем, что данные, передаваемые по протоколу HTTPS, остаются конфиденциальными и не могут быть подделаны или перехвачены злоумышленниками.

> Для шифрования используется криптографический алгоритм, который может быть **SSL** (*Secure Sockets Layer*) или **TLS** (*Transport Layer Security*) для обеспечения безопасности в `HTTPS`. Эти уровни безопасности получаются от доверенных центров сертификации (**CA** - Certificate Authorities), в виде сертификата. Это шифрование означает, что передаваемые данные не могут быть прочитаны любым другим человеком или ботом. Только браузер, который вы используете, и сервер могут расшифровать данные.
## Load-balancer
Балансировщик нагрузки — это сетевое устройство или программное обеспечение, которое распределяет входящий сетевой трафик между различными серверами для оптимизации эффективности и повышения надежности. В нашем случае, например, Google получает множество запросов на доступ к своей веб-странице. Таким образом, они не могут работать на одном сервере. Им потребуется несколько серверов, способных обрабатывать запросы и ответы. Следовательно, сведите к минимуму **SPOF** (*Single Point of Failure*).
> Балансировщики нагрузки управляют серверами и знают, какой сервер какой запрос будет обрабатывать. Балансировщик нагрузки равномерно распределяет рабочую нагрузку между различными серверами, следуя алгоритму балансировки нагрузки. Например, **HAproxy** — один из самых известных балансировщиков нагрузки, который можно настроить с помощью циклического алгоритма. При такой конфигурации запрос отправляется на один сервер, а затем на следующий, пока все серверы не обработают запрос, и цикл продолжается.
## Web Server
Как только балансировщик нагрузки распределяет запрос, он поступает на веб-сервер. Веб-серверы — это программное обеспечение, которое обслуживает веб-контент по запросу. Веб-контент включает в себя веб-страницы, изображения и файлы, а также другие ресурсы. Веб-серверы включают такие программы, как **Nginx**, **Apache** и **Microsoft Internet Information Services**(*IIS*).
> Получив запрос от балансировщика нагрузки, веб-сервер отвечает соответствующими ресурсами, которые перенаправляются балансировщику нагрузки и, в конечном итоге, браузеру.
## Application Server
Веб-серверы обрабатывают статический контент, но в большинстве случаев вам может потребоваться взаимодействовать с веб-сайтом. В нашем случае, когда вы вводите google.com, вы, скорее всего, захотите продолжить поиск других вещей в Google. `Application Servers` обрабатывают это взаимодействие. `Application Servers` обрабатывает динамический контент, включая управление пользовательской информацией, взаимодействие с базами данных, где это необходимо, и работу приложений.
> Таким образом, если **Nginx** получает запрос и если запрос представляет собой взаимодействие, **Nginx** перенаправляет запрос на `Application Server`. Если `Application Server` может ответить на запрос, он генерирует ответ и пересылает его на **Nginx**. Если `Application Server` не может сгенерировать ответ, поскольку ему требуется дополнительная информация, он перенаправляет запрос в базу данных.
## Database
База данных — это совокупность хорошо организованных и хранимых данных, обеспечивающих эффективный поиск, изменение и добавление данных. Существуют различные модели баз данных. Основными из них являются реляционные базы данных (*SQL*), такие как **MySQL** и **PostgreSQL**, и нереляционные базы данных (*NoSQL*), такие как **MongoDB** и **Cassandra**.

Для доступа к базе данных вам потребуется **DBMS**-**СУБД** (*Database Management System*). **СУБД** — это программное обеспечение, в котором есть инструменты и функции для создания, удаления, добавления, запроса и администрирования базы данных.
> Когда `Application Server` требуется дополнительная информация, он перенаправляет запрос в **СУБД**. **СУБД** взаимодействует с `базой данных` и отвечает `Application Server`. `Application Server`, в свою очередь, отвечает **Nginx**, который отвечает браузеру. После получения необходимых ресурсов браузер отображает всю страницу целиком.