---
sidebar_position: 2
---

# EC2
## Elastic Compute Cloud
Amazon **EC2** = Infrastructure as a Service
**EC2** состоит из:
- самого инстанса, виртуальной машины - **EC2 Instance**
- хранилище данных, виртуальный диск - **EBS volumes**
- распределяющего нагрузку между инстансами балансировщика - **ELB**
- масштабирующей сервисы группы - **ASG**

## EC2 sizing & configuration options
- OS: Linux, Windows, Mac OS
- CPU:
- Memory:
- Storage space:
  - Network-attached (**EBS** & **EFS**)
  - Hardware-attached (*EC2 Instance Store*)
- Network Cards
- Firewall rules: **Security Group**
- Bootstrap script (набор команд, выполняющихся при запуске инстанса, первый запуск): **EC2 User Data**

**EC2 User Data** нужен для установки обновлений, ПО, общих файлов из интернета, будь чего на самом деле. Запуск идет от root пользователя

![Instance Types](./img/ec2_instance_types.jpg)