---
sidebar_position: 3
---
# Python Zabbix - Active Directory Federation Services (ADFS) Users Validation
```python title="ZabbixUserValidationChecker" showLineNumbers
#!/usr/bin/python3
from pyzabbix import ZabbixAPI
import ldap
import os
from decouple import config

# Zabbix setup
zabbix_server = "https://zabbix-example.com/"
z = ZabbixAPI(zabbix_server)
## TLS CA certificate bundle
z.session.verify = "/etc/ssl/certs/example_rca.pem"
## Use zabbix-proxy environment variable for password
zabbix_sa_pass = os.getenv('ZABBIX_SA_PASS')
## Use service account for session
z.login("sa-internal-audits", zabbix_sa_pass)

# Define your list of aliases to skip
aliases_to_skip = [
    "Admin", 
    "api", 
    "guest",
    "sa-internal-audits"
    ]

# Fetch all users from Zabbix
users = z.user.get(output="extend")

# LDAP setup
ldap_server = "ldaps://example.com"
base_dn = "OU=Example,DC=prod,DC=example,DC=com"
ldap_login = "sa-auth-monitoring@prod.example.com"
ldap_password = config('pass_sa-auth-monitoring',default='')
ldap_connect = ldap.initialize(ldap_server)
ldap_connect.simple_bind_s(ldap_login, ldap_password)
ldap_connect.set_option(ldap.OPT_REFERRALS, 0)

# Function to check user existence in LDAP
def checkUserExistInLDAP(user_alias):
    object_to_search = f"(&(sAMAccountName={user_alias})(!(userAccountControl:1.2.840.113556.1.4.803:=2)))"
    try:
        result = ldap_connect.search_s(base_dn, ldap.SCOPE_SUBTREE, object_to_search, ["userPrincipalName"])
    except ldap.LDAPError as e:
        print("LDAP Search Error:", e)
        return False
    return len(result) > 0

# Initialize lists to collect users based on their LDAP status
not_active_users = []
skipped_users = []
active_users = []

# Iterate over Zabbix users and check them against LDAP
for user in users:
    alias = user['alias']
    # Skip LDAP check for aliases in the skip list or if "Pagerduty" is in the alias (case-insensitive)
    if alias in aliases_to_skip or "pagerduty" in alias.lower():
        skipped_users.append(f"{user['name']} {user['surname']} (Alias: {alias})")
        continue
    # Assuming the alias
    if checkUserExistInLDAP(alias):
        active_users.append(f"{user['name']} {user['surname']} (Alias: {alias})")
    else:
        not_active_users.append(f"{user['name']} {user['surname']} (Alias: {alias})")

# Only build and print the FlockML message if there are inactive users
if not_active_users:
    # Create FlockML output
    flockml_output = "<flockml>"

    # Output NOT Active in AD users first
    flockml_output += f"<b>NOT Active in AD ({len(not_active_users)}):</b><br/>" + "<br/>".join(not_active_users) + "<br/><br/>"

    # Output skipped users (count only)
    flockml_output += f"<b>Skipped checks:</b> {len(skipped_users)}<br/>"

    # Output Active in AD users (count only)
    flockml_output += f"<b>Active in AD:</b> {len(active_users)}<br/>"

    # Output Total Zabbix Users
    total_users_count = len(users)
    flockml_output += f"<b>Total Users in Zabbix:</b> {total_users_count}<br/>"

    # Close FlockML tag
    flockml_output += "</flockml>"

    # Print the final FlockML output
    print(flockml_output)
# If there are no inactive users, do nothing.
```