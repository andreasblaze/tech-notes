---
sidebar_position: 1
---
# Grafana Login Setup

В конфигурации самой Grafana надо указать следующее:
```jsx title="/etc/grafana/grafana.ini"
#################################### Auth LDAP ##########################
[auth.ldap]
enabled = false
config_file = /etc/grafana/ldap.toml

#################################### Auth ADFS ###########################
[auth.generic_oauth]
name = ADFS
enabled = true
allow_sing_up = true
client_id = *****
client_secret = *****
scopes = openid profile email
auth_url = https://auth.service.com/adfs/oauth2/authorize/
token_url = https://auth.service.com/adfs/oauth2/token/
api_url = https://auth.service.com/adfs/userinfo
use_pkce = true
use_refresh_token = true
skip_org_role_sync = true
```

