---
sidebar_position: 1
---

# General Info 

## Regions & Availability Zones

В AWS есть **Regions**, а есть **Availability Zones** (*AZ*).

**Regions** - по сути есть кластерами, которые состоят из **Availability Zones** (мин 3, макс 6).

AWS поддерживает несколько географических регионов - North America, South America, Europe, China, Asia Pacific, South Africa, and the Middle East.

Один регион - одна инфраструктура.
В каждой из  **Availability Zones** по **2** датацентра (или больше, мы не можем знать). Датацентры изолированы друг от друга.

Есть глобальные сервисы Амазона: 
- **IAM** - Identity and Access Management
- **Route53** - DNS service
- **CloudFront** - Content Delivery Network
- **WAF** - Web Application Firewall

А есть региональные: 
- **EC2** - Infrastructure as a Service
- **Elastic Beanstalk** - Platform as a Service
- **Lambda** - Function as a Service
- **Rekognition** - Software as a Service

! Обычно в AWS ты платишь за отправку данных из одной AZ в другую, но есть исключения, которые, в основном, работают для AWS-manage сервисов.