---
sidebar_position: 5
---
# ELB & ASG

## Elastic Load Balancing (ELB)
Elastic Load Balancing автоматически распределяет входящий трафик приложений по нескольким целевым объектам и виртуальным устройствам в одной или нескольких зонах доступности (AZ).

### Types of ELB
- Classic Load Balancer (**CLB**): старик, который задеприкейчен, но все еще используется - подходит для HTTP/S, TCP, SSL; 
- Application Load Balancer (**ALB**): новое поколение - подходит для HTTP/S, WebSocket - **7-й слой OSI** (прикладной);
- Network Load Balancer (**NLB**): TCP, TLS, UDP - **4-й слой OSI** (транспортный);
- Gateway Load Balancer (**GWLB**): самый новый - подходит для манипуляций с IP протоколом - **3-й слой OSI** (сетевой).
:::info

**ELB** имеет **SG** для приема траффика от пользователей, то есть allow HTTP/S, где source = anywhere. В то время как EC2 инстансы имеют **SG** для приема траффика от **ELB**, где source = **SG ELB**.

:::