---
sidebar_position: 11
---

# AWS CLI

## Install AWS CLI v2
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```
```bash
unzip awscliv2.zip
```
```bash
sudo ./aws/install
```
or
```bash
sudo ./aws/install --update
```
issue:
> andreasdesktop@AndreasDesktop:~$ aws --version
-bash: **/usr/bin/aws: No such file or directory**

Похоже, что может возникнуть конфликт с путями, по которым установлен **aws**. Исполняемый файл **AWS CLI** должен находиться в `/usr/local/bin`, но ваша оболочка пытается получить к нему доступ из `/usr/bin`.

### Verify AWS CLI Installation Directory:
```bash
ls /usr/local/bin/aws
```
> Если файл существует, вам необходимо обновить переменную среды **PATH**, включив `/usr/local/bin` перед `/usr/bin`.

### Update PATH Environment Variable:
Откройте файл конфигурации оболочки в текстовом редакторе:
```bash
nano ~/.bashrc
```
В конце файла надо добавить это:
```bash
export PATH=/usr/local/bin:$PATH
```
Сохраните файл и выйдите из редактора. Затем перезагрузите конфигурацию оболочки:
```bash
source ~/.bashrc
```
### Verify the Installation
```bash
aws --version
```

## SSO
```bash
aws configure sso
```

## EKS
```bash
aws eks update-kubeconfig --region <region-name> --name <cluster-name> --profile <configured-sso-profile-name>
```

```bash

```

```bash

```

```bash

```