---
sidebar_position: 3
---
# SSH
```bash
ssh -l andriibondariev@prod.example.com 10.20.100.200
```
```bash
scp -r /* root@10.20.100.200:/usr/lib/zabbix/externalscripts
```
или
```bash
scp -i myAmazonKey.pem script.sh ubuntu@3.135.180.100:/
```
## Место, где находится конфиг SSH
```bash
/etc/ssh/ssh_config
```
## Логин с указанием приватного ключа, юзернейма и хоста
```bash
ssh -i ~/.ssh/my_key -l myusername 10.20.100.200
```
## Логин под рутом с указанием юзернейма
```bash
ssh -i andriibondariev root@10.20.134.204
```
## Создание публичного ключа из приватного с указанием коммента
```bash
ssh-keygen -y -f /path/to/your/private/key -C "new-comment" > new_public_key.pub
```
## SSH and Git connectivity
Создайте ключ SSH: если у вас еще нет ключа SSH или вы хотите создать новый специально для этой цели.
```bash
ssh-keygen -t rsa -b 4096 -C "andrii.bondariev@example.com"
```

Укажите местоположение во время генерации ключа:
```bash
/c/Users/AndreasDesktop/.ssh/example
```

Добавьте Public Key на сервер Git:
```bash
cat /c/Users/AndreasDesktop/.ssh/example.pub
```

Убедитесь, что ssh-агент запущен:
```bash
eval $(ssh-agent -s)
```

Список ключей агента SSH:
```bash
ssh-add -L
```

Убедитесь, что ваш ключ example указан в списке. Если нет, добавьте еще раз:
```bash
ssh-add /c/Users/AndreasDesktop/.ssh/example
```

Проверьте прямое SSH-соединение:
```bash
ssh -T git@git.example.net
```
## Script Timeout and Disconnection

The message "client_loop: send disconnect: Broken pipe" typically indicates that the SSH connection to your server is timing out while your script is still running. This often happens with long-running processes in environments where there's a timeout on idle SSH connections.
Solutions:

    Prevent SSH Timeout: You can prevent the SSH session from timing out by sending a "keep alive" signal at regular intervals. This can be done by setting the following options in your SSH configuration (~/.ssh/config):

```plaintext
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 120
```
This configuration sends a keep-alive message every 60 seconds and allows up to 120 missed messages before disconnecting.

Using screen or tmux: These tools allow you to run sessions that continue even if you disconnect or log out from the SSH session. Start a screen or tmux session before running your script, which you can then detach from and reattach to later.

## SSH Config
```bash
Include /etc/ssh/ssh_config.d/*.conf
Host *
SendEnv LANG LC_*
    HashKnownHosts yes
    GSSAPIAuthentication yes

Host jump *jump-host-name*
    HostName *jump-host-name*
    User username@corporation
    IdentityFile ~/.ssh/aduser
    #Add connection multiplexing
    ControlMaster auto
    ControlPath ~/.ssh/%u@%h:%p
    ControlPersist 10m
 
Host !jump !*jump-host-name* *
    # some settings
    # some settings
    ProxyJump jump


Host *host-name*
    ProxyJump jump
    HostName *ip-address*
    User username@corporation
    IdentityFile /root/.ssh/aduser

```