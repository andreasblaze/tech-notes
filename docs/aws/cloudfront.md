---
sidebar_position: 9
---
# CloudFront

## Content Delivery Network
**CDN** помогает кешировать контент сайта на границах (`Edge Locations`), что ускоряет загрузку и улучшает юзер экспириенс.
[Networking: CDN](https://andreasblaze.github.io/networking/cdn)

**CloudFront** - **CDN** сервис от AWS. Предоставляет `DDoS` протекцию, интеграцию с **Shield**, **AWS Web Application Firewall**.

## CloudFront - Origins
:::info
**CloudFront** не может использоваться для запросов на контент к приватным `Origins` (по приватной сети) - только `Public`. Но и тут тоже надо править `SecurityGroup` (*Allow Public IP of* `Edge Locations` или в случае с **ALB** - *Allow SecurityGroup of LoadBalancer*).

Также можно настраивать `Allowlist`, `Blocklist` - явно указывать указывать с каких стран будет или не будет доступен контент. 
:::
- **S3 Bucket**: 
    - для распространения файлов и их кеширования на `PoP` (*Points of Presence* или `edge servers`); 
    - для гарантии, что именно **CloudFront** может иметь доступ к **S3** - можно использовать **OAC** (*Origin Access Control*);
    - **CloudFront** может использоваться в качестве отправителя данных в **S3** (`ingress`).
- **Custom Origin (HTTP)**
    - ALB;
    - EC2;
    - S3 Website;
    - Any HTTP backend.

## Pricing
Любые кэшируемые данные, передаваемые в `Edge Locations` **CloudFront** из ресурсов AWS, не требуют дополнительной оплаты. **CloudFront** взимает плату за передачу данных из `Edge Locations`, а также за запросы HTTP или HTTPS. Цены варьируются в зависимости от типа использования, географического региона и выбора функций.

### Price Class
- **Price Class All**: все регионы, лучший перформенс;
- **Price Class 200**: почти все регионы, кроме самых дорогих;
- **Price Class 100**: два самых дешевых региона (Северная Америка, Европа и Израиль).

## Cache Invalidation
В случаях, когда мы обновляем бекенд `Origins`, то **CloudFront** (`Edge Locations`) получит обновленный контент после того, как истечет `TTL`. Но можно обновить кеш насильно (удалить его из `Edge Locations`), используя `CloudFront Invalidation`. Можно указать как и все файлы, так и указать специальный путь (*/images/* *).

## Anycast and Unicast
**Unicast**: каждая нода в сети получает уникальный IP-адрес, один сервер содержит один IP адрес - клиент обращается напрямую к каждому серверу по его IP.

**Anycast**: каждая нода в сети имеет один и тот же IP-адрес, все серверы содержат один IP адрес - клиент обращается к близжайшему серверу.

**CDN** сервисы используют `Anycast` как метод роутинга. Если к одному и тому же `Origin Server` одновременно отправляется множество запросов, `Origin Server` может быть перегружен трафиком и не сможет эффективно отвечать на дополнительные входящие запросы. В сети `Anycast` вместо одного `Origin Server`, принимающего на себя основную нагрузку трафика, нагрузка также может быть распределена по другим доступным центрам обработки данных, каждый из которых будет иметь серверы, способные обрабатывать входящий запрос и отвечать на него. Этот метод маршрутизации может помешать исходному серверу расширить емкость и избежать перебоев в обслуживании клиентов, запрашивающих контент с `Origin Server`.

## Global Accelerator
**AWS Global Accelerator** — это сетевой сервис, который помогает повысить доступность, производительность и безопасность общедоступных приложений (*Public Applications*). 

**Global Accelerator** использует `Anycast` как метод роутинга, предоставляет два глобальных статических общедоступных IP-адреса (`2 Anycast IP`), которые действуют как фиксированная точка входа к конечным точкам вашего приложения, например `ALB`, `NLB`, `EC2` и `Elastic IP's` - Public or Private.

`Anycast IP` отправит траффик напрямую близжайшему `Edge Locations`. Псоле `Edge Locations` отправит траффик к нашему приложению через приватную сеть AWS.

**Global Accelerator** имеет хелсчеки на наше приложение и DDoS протекцию (**AWS Shield**).

## CloudFront vs AWS Global Accelerator
**AWS CloudFront** и **AWS Global Accelerator** — это **CDN** сервисы, но они имеют разные функции и варианты использования.

### CloudFront
**CloudFront** — это глобальная сеть доставки контента (CDN), которая доставляет контент с `Origin Servers` пользователям по всему миру с низкой задержкой и высокой скоростью передачи. Он предназначен для кэширования и распространения статического и динамического контента, такого как веб-страницы, изображения и видео, а также для снижения нагрузки на `Origin Server`. **CloudFront** обычно используется для повышения производительности и доступности веб-приложений и веб-сайтов.

### Global Accelerator
**Global Accelerator** — это сервис, который маршрутизирует трафик через глобальную сеть AWS для повышения доступности и производительности интернет-приложений. Он предоставляет статический произвольный IP-адрес, который действует как единая точка входа для всего трафика, поступающего в приложение, и направляет трафик к оптимальной конечной точке AWS с учетом близости и работоспособности. **Global Accelerator** обычно используется для повышения доступности и производительности трафика `TCP` и `UDP` для приложений, которым требуется высокая доступность и низкая задержка, например игровые, финансовые и медицинские приложения (*non-HTTP use cases*). Когда надо сделать быстрый региональный фейловер.

### Summary
Подводя итог, можно сказать, что **CloudFront** — это **CDN**, который кэширует и распределяет контент для повышения производительности сети, а **Global Accelerator** — это сервис маршрутизации трафика, который повышает доступность и производительность `TCP`- и `UDP`-трафика для интернет-приложений. Выбор между двумя сервисами зависит от конкретного варианта использования и требований приложения.