---
sidebar_position: 1
---
# Postgres

## Log in to PostgreSQL

First, you need to log in to your PostgreSQL server as a superuser, usually postgres. You can do this from the command line:
```bash
psql -U postgres
```
## Create the User
Use the `CREATE ROLE` or `CREATE USER` command to create a new user. The `CREATE USER` command is a shortcut for `CREATE ROLE` with the `LOGIN` attribute enabled, which is usually what you want for a backup user.
```bash
CREATE USER backup_user WITH PASSWORD 'secure_password';
```
## Granting Necessary Permissions
Depending on what the user needs to do, you'll grant different permissions. For running backups with pg_basebackup, the user needs replication privileges.
```bash
ALTER ROLE backup_user REPLICATION;
```
```bash

```
```bash

```
```bash

```
```bash

```

## Backup
```bash
pg_basebackup -X fetch --format=tar -h localhost -U postgres -D - | lbzip2 -n 6 -9 > backup.tar.bz2
```
This command does the following:

-    -X fetch: Includes all required WAL files in the backup. This can also be -X stream which streams WAL records required to make the backup consistent, but since you are using stdout for your directory, it's safer to use fetch here.
-    -D -: The directory parameter is set to stdout, indicated by -.
-    | lbzip2 -n 6 -9 > backup.tar.bz2: This pipes the output of pg_basebackup directly to lbzip2 for compression with settings for high compression (option -9), and outputs the compressed backup to backup.tar.bz2.
```bash
pg_basebackup -X fetch --format=tar -d "host=localhost user=postgres sslmode=disable" -D - | lbzip2 -n 6 -9 > ~/backup/backup.tar.bz2
```
This command specifies the host, user, and SSL mode directly in the connection string:

-    -d sets the connection string.
-    "host=localhost user=postgres sslmode=disable" specifies that the connection is to localhost, as the user postgres, with SSL disabled.

## Postgres connection issue
The error **pg_basebackup: error: connection to server at "localhost" (::1), port 5432 failed: FATAL: no pg_hba.conf entry for replication connection from host "::1", user "postgres"**, SSL off suggests that the PostgreSQL server's pg_hba.conf file does not have an entry allowing replication connections from the localhost (::1) for the user postgres without SSL.

To resolve this, you need to edit the pg_hba.conf file
```bash
psql -U postgres -c "SHOW config_file;"
```
```bash
psql -U postgres -c "SHOW hba_file;"
```

These commands will output the path to the postgresql.conf and pg_hba.conf files, respectively.
```bash
sudo find / -name "pg_hba.conf" 2>/dev/null
```
```bash
sudo find / -name "postgresql.conf" 2>/dev/null
```

These commands will search the entire filesystem for these files, excluding permission error messages.
## Configure pg_hba.conf (HBA stands for host-based authentication)
```plaintext
# TYPE  DATABASE  USER  ADDRESS       METHOD
host    all       all   ::1/128       trust
local   replication     backup_user   md5 (e.g., md5 for password-based authentication)
local               database  user  auth-method [auth-options]
host                database  user  address     auth-method  [auth-options]
hostssl             database  user  address     auth-method  [auth-options]
hostnossl           database  user  address     auth-method  [auth-options]
hostgssenc          database  user  address     auth-method  [auth-options]
hostnogssenc        database  user  address     auth-method  [auth-options]
host                database  user  IP-address  IP-mask      auth-method  [auth-options]
hostssl             database  user  IP-address  IP-mask      auth-method  [auth-options]
hostnossl           database  user  IP-address  IP-mask      auth-method  [auth-options]
hostgssenc          database  user  IP-address  IP-mask      auth-method  [auth-options]
hostnogssenc        database  user  IP-address  IP-mask      auth-method  [auth-options]
include             file
include_if_exists   file
include_dir         directory
```
## Reload PostgreSQL Configuration
After making changes to pg_hba.conf, you need to reload the PostgreSQL server configuration for the changes to take effect. This can be done without restarting the database:
```bash
SELECT pg_reload_conf();
```
or from the command line:
```bash
pg_ctl reload
```
Reload PostgreSQL to apply changes:
```bash
systemctl reload postgresql
```
and after:
```bash
systemctl status postgresql
```
Check Logs:
```bash
/var/log/postgresql/
```
## Verify PostgreSQL is Listening Correctly
Check postgresql.conf for the listen_addresses setting:
```bash
nano /var/lib/postgresql/15/main/postgresql.conf
```
Make sure it's set to listen on all interfaces or specifically includes localhost or ::1:
```bash
listen_addresses = 'localhost'  # or '127.0.0.1, ::1' or '*'
```
