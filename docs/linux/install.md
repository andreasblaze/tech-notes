# Install Debian

## Restart the VM
- Power off the VM
- Edit the VM → Mount the Debian netinst ISO (e.g. debian-12.x.x-amd64-netinst.iso)
- Set the VM to boot from CD/DVD first (in the VM's boot options)

## Begin the Debian Installer (Text Mode)
- Select `“Install”` or “Graphical Install” — (use server version)
- Go through the steps:
- - Language
- - Locale
- - Keyboard
- - Hostname: `<HOST_NAME>` # like a VM name
- - Leave domain name empty or set to something like `corp.example.net`
- - Create `root` or admin user

## Partitioning
`Guided – use entire disk → All files in one partition`

## Software Selection
- [ ] Debian desktop environment
- [x] standard system utilities
- [x] SSH server

## Install GRUB to /dev/sda when prompted
`Confirm GRUB install → select /dev/sda when asked`

## Test Network and SSH
```bash
ip a
```
```bash
ip addr show
```
```bash
systemctl status ssh
```

## To disable the CD-ROM as a package source, and allow apt to download packages from online mirrors.
```bash
nano /etc/apt/sources.list
```
```plaintext
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
```
### Refresh the package list
```bash
apt update
```
## Install Required Packages
```bash
apt install -y realmd sssd sssd-tools sshpass adcli krb5-user libnss-sss libpam-sss samba-common-bin packagekit git ansible curl
```
|Package | Purpose|
| ------ | ------ |
|realmd | Joins Linux machine to Active Directory|
|sssd | Handles authentication and caching|
|sshpass | Ansible uses SSH when `--ask-pass` used|
|adcli | Assists joining AD domains|
|krb5-user | Kerberos support (authentication to domain)|
|libnss-sss, libpam-sss | Allows Linux to resolve AD users and groups|
|samba-common-bin | Provides tools needed for domain joining |
|git | To work with git repositories|
|ansible | This will install ansible, ansible-galaxy, ansible-playbook and other necessary tools|
|curl | to make http requests|

## SSH + AD Setup
After previous instructions need to fill next configurations from examples:
| File Name                                     | Purpose                                    |
| --------------------------------------------- | ------------------------------------------ |
| /etc/krb5.conf                                | Kerberos config (for authentication to AD) | 
| /etc/sssd/sssd.conf                           | SSSD configuration (for user/group access) | 
| /etc/ssh/sshd_config (only specific parts)    | SSH settings (restrictions, login rules)   | 
| /etc/sudoers.d/ files (specific to AD groups) | Sudo permissions for AD groups/users       |

### Adjust Permissions
Especially for `sssd.conf`:
```bash
chmod 600 /etc/sssd/sssd.conf
```
```bash
chown root:root /etc/sssd/sssd.conf
```

### Rejoin the domain
```bash
realm leave corp.example.net
```
```bash
realm join --user=andriibondariev corp.example.net
```

### Restart Services
```bash
systemctl restart sssd
```
```bash
systemctl restart ssh
```

### To remove or disable the local user to avoid confusion, and keep only the AD user.
```bash
getent passwd andriibondariev
```
- Disable:
```bash
usermod -L andriibondariev
```
- Delete:
```bash
deluser andriibondariev
```

## Ansible
### Make a Git connectivity
```bash
eval $(ssh-agent -s)
```
```bash
ssh-add /c/Users/AndreasDesktop/.ssh/example
```
```bash
chmod 600 /root/.ssh/example
```
### Create requirements.yml
```bash
---
- src: git+ssh://git@git.example.net/sre/ansible-role-jenkins_agent.git
  version: master
```
### Install the role
```bash
ansible-galaxy install -r requirements.yml -p roles
```
### Create Your Playbook
Create a file `install-jenkins-agent.yml`:
```bash
---
- name: Install Jenkins Agent Dependencies
  hosts: jenkins_agents
  gather_facts: yes
  become: true

  roles:
    - ansible-role-jenkins_agent
```
### Create Inventory
Create a file `inventory.ini`:
```bash
[jenkins_agents]
phx01-sre-sps-01 ansible_host=<IP> ansible_user=andriibondariev
```
### Run the Playbook
```bash
ansible-playbook -i inventory.ini install-jenkins-agent.yml --ask-pass
```
```bash

```
```bash

```