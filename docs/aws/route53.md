---
sidebar_position: 6
---

# Route 53
**Route 53** — это высокодоступный (единственный AWS сервис, который предоставляет 100% SLA) и масштабируемый веб-сервис DNS. Можно использовать Route 53 для выполнения трех основных функций в любой комбинации: 
- регистрации домена;
- маршрутизации DNS;
- проверки работоспособности, хелсчеки.

**Route 53** - это `Authoritative Nameserver`, где можно управлять `DNS Records`. **53** - потому, что это традиционный DNS порт.

## Hosted Zones
### Public Hosted Zones
Содержат записи, которые указывают как роутить траффик в Интернет (public domain names, application1.mypublicdomain.com).
### Private Hosted Zones
Содержат записи, которые указывают как роутить траффик в пределах одного или нескольких VPC (private domain names, application1.company.internal).
:::info
**Hosted Zones** обойдутся в $0.50/месяц за зону.
:::

## Domains
Регистрация домена происходит во вкладке `Domains`. Можно перенести существующий или зарегистрировать за деньги новый. При регистрации появится 4 записи домена: `A`, `NS`, `SOA`, `CNAME` (www).

Домену можно создать запись, для этого надо указать `Record name` (test.example.com), `Record type` (A), `Value` (11.22.33.44), `TTL` (300), `Routing policy`.