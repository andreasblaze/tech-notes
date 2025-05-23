# /etc/krb5.conf
```bash
# Configuration snippets may be placed in this directory as well
includedir /etc/krb5.conf.d/

includedir /var/lib/sss/pubconf/krb5.include.d/
[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 rdns = false
 pkinit_anchors = FILE:/etc/pki/tls/certs/ca-bundle.crt
# default_realm = EXAMPLE.COM
 default_ccache_name = KEYRING:persistent:%{uid}

 default_realm = CORP.EXAMPLE.NET
[realms]
# EXAMPLE.COM = {
#  kdc = kerberos.example.com
#  admin_server = kerberos.example.com
# }

 CORP.EXAMPLE.NET = {
 }

[domain_realm]
# .example.com = EXAMPLE.COM
# example.com = EXAMPLE.COM
 corp.namecheap.net = CORP.EXAMPLE.NET
 .corp.namecheap.net = CORP.EXAMPLE.NET
```