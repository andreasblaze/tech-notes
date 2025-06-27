# Grafana User Deletion | LDAP | Dry Run
```python title="ZabbixUserValidationChecker" showLineNumbers
import requests
import ldap
import json

# ==== Config ====
grafana_url = "https://grafana.com"
api_token = "<GRAFANA-API-TOKEN>"
ca_bundle_path = "/etc/ssl/certs/example_rca.pem"
ldap_server = "ldaps://prod.example.net"
ldap_user = "sa-user@prod.example.net"
ldap_password = "<LDAP-SA-PASSWORD>"
base_dn = "OU=Example,DC=prod,DC=example,DC=net"

# Safe mode
dry_run = True

# Skip deletion for these users
whitelist = [
    "admin",
    "test"
]

# ==== Setup Grafana ====
headers = {
    "Authorization": f"Bearer {api_token}",
    "Content-Type": "application/json"
}
list_users_url = f"{grafana_url}/api/org/users"
delete_user_url = f"{grafana_url}/api/org/users"  # /:id

# ==== Setup LDAP ====
ldap_conn = ldap.initialize(ldap_server)
ldap_conn.set_option(ldap.OPT_REFERRALS, 0)
ldap_conn.simple_bind_s(ldap_user, ldap_password)

def is_user_active_in_ad(email):
    filter = f"(&(mail={email})(!(userAccountControl:1.2.840.113556.1.4.803:=2)))"
    try:
        result = ldap_conn.search_s(base_dn, ldap.SCOPE_SUBTREE, filter, ["userPrincipalName"])
        return len(result) > 0
    except ldap.LDAPError as e:
        print(f"LDAP error for {email}: {e}")
        return False

def delete_grafana_user(user_id, user_email):
    delete_url = f"{delete_user_url}/{user_id}"
    try:
        res = requests.delete(delete_url, headers=headers, verify=ca_bundle_path)
        if res.status_code == 200:
            print(f"Deleted: {user_email}")
        else:
            print(f"Failed to delete {user_email}: {res.status_code} {res.text}")
    except Exception as e:
        print(f"Request error deleting {user_email}: {e}")

def main():
    try:
        response = requests.get(list_users_url, headers=headers, verify=ca_bundle_path)
        response.raise_for_status()
        users = response.json()
    except Exception as e:
        print(f"Failed to get users: {e}")
        return

    total = len(users)
    deleted = 0
    skipped = 0
    for u in users:
        email = u.get("email")
        name = u.get("name")
        uid = u.get("userId")

        if not email or email in whitelist:
            skipped += 1
            continue

        if is_user_active_in_ad(email):
            skipped += 1
            continue

        print(f"Inactive in AD: {name} ({email})")
        if not dry_run:
            delete_grafana_user(uid, email)
            deleted += 1
        else:
            print(f"Dry run: would delete user {email} (ID {uid})")

    print("\n=== Summary ===")
    print(f"Total Grafana users: {total}")
    print(f"Skipped: {skipped}")
    print(f"To delete: {total - skipped}")
    print(f"{'Dry run — nothing deleted.' if dry_run else f'Deleted: {deleted}'}")

if __name__ == "__main__":
    main()
```