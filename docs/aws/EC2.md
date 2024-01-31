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

![Instance Types 1](./img/ec2_instance_types.jpg)
![Instance Types 2](./img/ec2_instance_types.png)
![Instance Types 3](./img/ec2_instance_types2.png)
[List of all instances types](https://instances.vantage.sh/)

## EC2 Creating

1. При создании EC2 инстанса нам нужно выбрать **Name** и проставить **Tags**: `Key`, `Value`, `Resource types`;
2. Далее нужно выбрать базовый образ для инстанса - **Image**;
3. Далее надо выбрать тип инстанса - **Instance type**;
4. Далее нужно создать ключевую пару для логина на инстанс - **Key pair**;

:::note

Ключевая пара SSH использует технологию public key infrastructure (PKI). Пара ключей — это открытый (*Public*) и закрытый ключи (*Private*). **Private** ключ является секретным, известен только пользователю, его следует зашифровать и безопасно хранить. **Public** ключ может быть свободно передан любому SSH-серверу, к которому пользователь желает подключиться.
* Пример генерации пары:
```bash
ssh-keygen -t ed25519/rsa -C "your_email@example.com"
```
* Пример использования: Добавить **Public Key** как **Deploy Key** в репозиторий [andreasblaze.github.io](https://github.com/andreasblaze/andreasblaze.github.io) и добавить **Private Key** в **GitHub Actions Secrets**.
То шо .pem - **Public Key**, без - **Private Key**.
* Пример подключения к инстансу:
```bash
ssh -i <file_name>.pem <user_name>@<public_ip>
```
* Если есть проблема с доступом (unprotected private key file):
```bash
chmod 0400 <file_name>.pem
```

:::

:::caution

На сервере **Public** ключ, у пользователя **Private** ключ. Каждый раз, когда вы обращаетесь к серверу, происходит сопоставление ключей.

:::

5. Далее идут Network settings, где определяется фаерволл - **Security Group**;
:::info

**Security Group** действует как виртуальный фаерволл для Amazon EC2 instances, AWS Lambda, AWS Elastic Load Balancing и контролирует входящий и исходящий трафик. При запуске инстанса вы можете указать одну или несколько **Security Groups**. Одна **Security Group** может применяться к разным инстансам. **Security Group** прикреплена к одному региону и одной **VPC**.
> "Timeout" - **Security Group** Issue.

> "Connection refused" - Application Issue.

**Security Group** регулирует:
- Доступ к портам (**Ports**);
- **IP** ренжи (IPv4 & IPv6);
- Входящие (**Inbound** or **ingress**) правила контролируют входящий трафик к вашему инстансу (кому и как можно пользоваться инстансом), а исходящие (**Outbound** or **egress**) правила — исходящий трафик из вашего инстанса (кому и как инстанс что-то передает).
:::

6. Далее **Configure storage**, где мы определяем размер и тип корневого тома (`Root volume`). В Advanced режиме можно наконфигурировать кастомные тома используя EBS (*block-storage service*);

:::note

**S3** provides you with a web interface while **EBS** provides a file system interface and EFS provides a web and file system interface. Storage Type: **AWS S3 is object storage** while **Amazon EBS is block storage** and Amazon EFS is file storage.

:::

7. **User Data** - скрипт при запуске.

:::danger

Никогда не надо запускать `aws configure` на EC2, так как это приведет к тому, что персональные токены будут доступны любому пользователю на EC2. Лучше использовать IAM Role.

:::