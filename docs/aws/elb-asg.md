---
sidebar_position: 5
---
# ELB & ASG

## Elastic Load Balancing (ELB)
Elastic Load Balancing автоматически распределяет входящий трафик приложений по нескольким целевым объектам и виртуальным устройствам в одной или нескольких зонах доступности (AZ).

### CLB
- Classic Load Balancer (**CLB**): старик, который задеприкейчен, но все еще используется - подходит для HTTP/S, TCP, SSL;
### ALB 
- Application Load Balancer (**ALB**): новое поколение - подходит для `HTTP/S`, `WebSocket` - **7-й слой OSI** (прикладной);
    - Балансирует нагрузку к множеству HTTP приложений, поддерживает редиректы с `http` на `https`, `роутинг по URL путям` (*один **ALB** может использоваться для нескольких таргет групп инстансов, Lambda, IPs*);
    - Отлично подходит для микросервисов и `container-based` приложений;
### NLB
- Network Load Balancer (**NLB**): TCP, TLS, UDP - **4-й слой OSI** (транспортный);
    - Балансирует `TCP&UDP` траффик на инстансы;
    - **NLB** имеет 1 статический IP для каждой AZ и поддерживает назначение  **Elastic IP** (полезно для вайтлиста конкретных IP);
    - **NLB** используется для высоких нагрузок и имеет более низкую задержку, чем **ALB**.
    - **NLB** Helth Checks поддерживают 3 протокола: `TCP`, `HTTP`, `HTTPS`.
### GWLB
- Gateway Load Balancer (**GWLB**): самый новый - подходит для манипуляций с IP протоколом - **3-й слой OSI** (сетевой).
    - используется для обнаружений злоумышленников на сетевом уровне и подходит для фаерволов;
    - является комбинацией **TNG** (Transparent Network Gateway) - вход/выход для всего траффика, и **Load Balancer** - распределяет трафик на ваши виртуальные устройства;
    - Использует `GENEVE` протокол на `6081` порту.
:::info

**ELB** имеет **SG** для приема траффика от пользователей, то есть allow HTTP/S, где source = anywhere. В то время как EC2 инстансы имеют **SG** для приема траффика от **ELB**, где source = **SG ELB**.

:::

## Sticky Sessions (Session Affinity - привязка сеанса)
Имеется ввиду имплементация подхода редиректа одного и того же клиента через лоад балансер к одному и тому же инстансу. Типо, один клиент посылает 2 запроса и эти два запроса попадают на один и тот же инстанс.

Данный подход будет работать для **CLB**, **ALB** и **NLB**. Он нужен для контроля сессиями пользователей.

Можно контролировать истечение срока действия cookie (когда срок истечет, то клиент будет редиректиться на другой инстанс), но **NLB** работает без cookie. Куки бывают Application-based(генерируются таргет групой, инстансами) и Duration-based(генерируются ЛБ).

## Cross-Zone Load Balancing
Эта такая фича, когда у нас есть несколько LB в разных AZ и нам надо, чтобы траффик распределялся по инстансам с одинаковой пропорцией. Без Cross-Zone Load Balancing траффик будет распределяться по каждой AZ отдельно (если у нас по 1 LB на 2 AZ, траффик делится на пополам и после распределяется по инстансам), а с Cross-Zone Load Balancing - как буд-то инстансы в AZ объеденены.

Данная фича бесплатная и по-дефолту работающая для **ALB**. Для **NLB** и **GWLB** она платная и по-дефолту неработающая. Для **CLB** по-дефолту неработающая, но бесплатная.

## SSL & TLS
- **SSL** и **TLS** по сути тоже самое, только **TLS** новее;
- **SSL** сертификат позволяет траффику между клиентами и лоад балансером быть зашифрованным в транзите (in-flight encryption);
- **SSL** относится к Secure Sockets Layer, что используется для шифрования соединений;
- **TLS** относится к Transport Layer Security, что является новой версией;
- Публичные **SSL** сертификаты выдаются центрами сертификации **CA** (Certificate Authorities).

SSL certificate termination - это то, что делает LB, процесс расшифровки зашифрованного трафика перед его передачей на веб-сервер. Load Balancers используют **X.509** сертификат (SSL-TLS server certificate).

### AWS Certificate Manager (ACM)
AWS предлагает клиентам два варианта развертывания управляемых сертификатов X.509. Выберите лучший вариант для ваших нужд:
- AWS Certificate Manager (**ACM**) - этот сервис предназначен для корпоративных клиентов, которым требуется безопасное присутствие в Интернете с использованием TLS. Сертификаты ACM развертываются через **Elastic Load Balancing**, **Amazon CloudFront**, **Amazon API Gateway** и других интегрированных сервисов AWS. **ACM** также упрощает управление безопасностью за счет автоматизации обновления сертификатов с истекающим сроком действия.
- AWS Private CA - этот сервис предназначен для корпоративных клиентов, создающих инфраструктуру public key infrastructure (**PKI**) внутри облака AWS и предназначенную для частного использования внутри организации. С помощью AWS Private CA вы можете создать собственную иерархию центров сертификации (**CA**) и выдавать с ее помощью сертификаты для аутентификации пользователей, компьютеров, приложений, сервисов, серверов и других устройств. Сертификаты, выданные private CA, нельзя использовать в Интернете.
### Server Name Indication (SNI)
В ходе создания TLS-подключения клиент запрашивает цифровой сертификат у web-сервера; после того, как сервер отправляет сертификат, клиент проверяет его действительность и сравнивает имя, с которым он пытался подключиться к серверу, с именами, содержащимися в сертификате. Если сравнение успешно, происходит соединение в зашифрованном режиме.

Server Name Indication (**SNI**) — расширение компьютерного протокола **TLS**, которое позволяет клиенту сообщать имя хоста, с которым он желает соединиться во время процесса «рукопожатия, SSL handshake». Это позволяет серверу предоставлять несколько сертификатов на одном IP-адресе и TCP-порту, и, следовательно, позволяет работать нескольким безопасным (HTTPS) сайтам (или другим сервисам поверх TLS) на одном IP-адресе без использования одного и того же сертификата на всех сайтах.

## Connection Draining
Для CLB - это Connection Draining, а для ALB/NLB - это Deregistration Delay.

Это время для завершения "in-flight requests" пока инстанс деактивируется или не проходит хелс чек. Этот Draining период дается для того, чтобы пользователи завершили свои сеансы и существующие запросы были выполнены и когда все будет сделано - все коннекшены будут отрублены.
:::info

**Draining период** можно установить от `1` до `3600` секунд. Дефолт - `300` секунд (5 минут). Также можно его убрать, установив параметр в `0`. Норма это ~`30` секунд.

:::

## Auto Scaling Group
**Auto Scaling Group** содержит коллекцию **EC2** инстансов, которые рассматриваются как логическая группа в целях автоматического масштабирования и управления. **Auto Scaling Group** также позволяет использовать функции автоматического масштабирования **EC2**, такие как `health check replacements` и `scaling policies`.

**Auto Scaling Group** - бесплатное решение, которое поможет контролировать нагрузку на группу инстансов (добавлять новые или убирать ненужные).

**Auto Scaling Group** - классно использовать вместе с ELB, бо один распределяет траффик, а другая подставляет и убирает инстансы, когда нужно.

У **ASG** есть **Launch Template**, в котором мы указываем то, что обычно указываем при создании **EC2** - `AMI`, `Instance Type`, `EBS Volumes`, `SG`, `SSH Key Pairs`, `IAM Role`, `VPC + Subnets`, `Load Balancer` ...
+ `Min Size / Max Size / Initial Capacity` + `Scaling Policies` (можно настроить полиси по **CloudWatch** алярму, по **Average CPU** для всей ASG, или кастомной метрике).

### Scaling Policies
- **Dynamic Scaling**:
    - **Target Tracking Scaling**: например, установка кондишена на Average ASG CPU ~40%.
    - **Simple / Step Scaling**: использование алармов CloudWatch, что если CPU > 70%, то добавить 2 инстанса, если CPU < 30%, то убрать 1 инстанс.
- **Scheduled Scaling**: предвидеть масштабируемость на основании извесного паттерна использования (можно ориентироваться на оперделенные даты, время - ночное, например).
- **Predictive scaling**: когда мы даем возможность ASG смотреть в будующее и выставлять автоматический скейлинг, на основании наших данных.
:::info

Чтобы использовать скейлинг, можно опираться на следующие метрики: `CPUUtilization`, `RequestCountPerTarget`, `Average Network In/Out` или просто **CloudWatch**.

:::