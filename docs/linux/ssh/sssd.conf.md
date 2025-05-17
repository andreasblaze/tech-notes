# /etc/sssd/sssd.conf
```bash
[sssd]
domains = corp.example.net
default_domain_suffix = corp.example.net
config_file_version = 2
services = nss, pam
certificate_verification = no_ocsp

[nss]
shell_fallback = /bin/sh
allowed_shells = /bin/sh,/bin/rbash,/bin/bash
filter_groups = root
filter_users = root

#ldap_id_use_start_tls = true

[pam]
pam_cert_auth = True

[domain/corp.example.net]
ad_domain = corp.example.net
krb5_realm = CORP.EXAMPLE.NET
realmd_tags = manages-system joined-with-samba
cache_credentials = True
id_provider = ad
krb5_store_password_if_offline = True
default_shell = /bin/bash
ldap_id_mapping = True
use_fully_qualified_names = True
fallback_homedir = /home/%u@%d
access_provider = ad
ad_access_filter = DOM:CORP.EXAMPLE.NET:(&(!(UserAccountControl:1.2.840.113556.1.4.803:=2))(memberOf:1.2.840.113556.1.4.1941:=CN=DL_Local-PHX01ADMSRE_Users,OU=Roles,OU=Local,OU=Service Groups,DC=corp,DC=example,DC=net))
```