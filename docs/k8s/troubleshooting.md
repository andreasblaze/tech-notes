
---
sidebar_position: 2
---
# Troubleshooting

## OOMKilled
Container in pod has been OOMKilled 1 times in the last 120 minutes. По памяти планка идет 286 Мб, т.е. до лимита 364М, вроде запасик был.
> Скорее всего киллер его прибил, потому что на ноде было недостаточно ресурсов. У вас реквесты низковатые. Только реквест гарантируется. Лимит не гарантируется. Поду просто дают жрать выше реквеста, но ниже лимита только в случае, если на ноде есть свободные ресурсы.

help to identify problem:
We got PD alerts for this errors:
"*22218811 upstream prematurely closed connection while reading response header from upstream, client: 172.29.35.56, server: internal-domainregistryprovider.apps.prod-1.us-west-2.spaceship.net, request: "POST /api/v1/domainregistryprovider/create HTTP/1.1", upstream: "http://172.29.62.66:8080/api/v1/domainregistryprovider/create", host: "internal-domainregistryprovider.apps.prod-1.us-west-2.spaceship.net"
Then
"2024/06/25 19:45:14 [error] 1229#1229: *22218758 connect() failed (111: Connection refused) while connecting to upstream, client: 172.29.108.12, server: internal-domainregistryprovider.apps.prod-1.us-west-2.spaceship.net, request: "POST /api/v1/domainregistryprovider/nameserversupdate HTTP/1.1", upstream: "http://172.29.62.66:8080/api/v1/domainregistryprovider/nameserversupdate", host: "internal-domainregistryprovider.apps.prod-1.us-west-2.spaceship.net""

We analyzed logs for our service and not found any timeouts. Request to service was interrupted over 2 second from start.
Please review if it was network AWS issue?
Host- domainregistryprovider-7b6b96c65c-wm4r2
Timestamp - 25.06.2024 22:45:14.212
Answer:
Upstream Pod stopped receiving requests:
https://dashboards.logs.prod-1.us-west-2.spaceship.net/_dashboards/goto/bbb457d7061613f4ade9bf6c0658c0a3?security_tenant=global

Also according to kube events container inside pod was restarted, most probably OOM:
https://dashboards.logs.prod-1.us-west-2.spaceship.net/_dashboards/goto/2c1569e7ed6192c50823452697e636d7?security_tenant=global