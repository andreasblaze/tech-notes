# MySQL
## Log in
```bash
mysql -u root
```
## List all databases:
```sql
SHOW DATABASES;
```
## Select database
```sql
USE <database-name>;
```
## Exit
```sql
exit;
```
## Export Results
```bash
mysql -u root -p -D grafana -e "SELECT id FROM alert WHERE datasource;" > elasticsearch_alerts.txt
```

## Docker
### Find the container name
```bash
docker ps
```
### Connect to the MySQL container
```bash
docker exec -it mysql-slave mysql -u root -p
```

## Grafana
### Alerts & Datasources
A table of alerts that do not use ES5-MSS-PROD (000000013) datasource for alerting
```sql
SELECT ar.uid, ar.title, ds.name AS datasource_name FROM alert_rule ar JOIN data_source ds ON ar.data LIKE CONCAT('%', ds.uid, '%') WHERE ds.type = 'elasticsearch' AND ar.data NOT LIKE '%000000013%';
+--------------------------------------+--------------------------------------+-------------------+
| uid                                  | title                                | datasource_name   |
+--------------------------------------+--------------------------------------+-------------------+
```
### Dashboards & Datasources
```sql
SELECT uid, title FROM dashboard WHERE JSON_UNQUOTE(JSON_EXTRACT(data, '$.panels')) LIKE '%elasticsearch%' OR JSON_UNQUOTE(JSON_EXTRACT(data, '$.templating')) LIKE '%elasticsearch%';
+--------------------------------------+------------------------------------------------+
| uid                                  | title                                          |
+--------------------------------------+------------------------------------------------+
```
### Datasources
```sql
MariaDB [grafana]> SELECT uid, name, type FROM data_source WHERE type = 'elasticsearch';
+--------------------------------------+-------------------------+---------------+
| uid                                  | name                    | type          |
+--------------------------------------+-------------------------+---------------+
```

## Zabbix
```sql
SELECT hostid, name FROM hosts WHERE name = '<Template-NAME>';
+--------+-------------------------------------+
| hostid | name                                |
+--------+-------------------------------------+
|  10330 | <Template-NAME>                     |
+--------+-------------------------------------+
```
```sql
SELECT h.hostid, h.host, h.name, i.ip FROM hosts h JOIN hosts_templates ht ON h.hostid = ht.hostid JOIN interface i ON h.hostid = i.hostid WHERE ht.templateid = (SELECT hostid FROM hosts WHERE name = '<Template-NAME>');
+--------+-----------------------+-----------------------+--------------+
| hostid | host                  | name                  | ip           |
+--------+-----------------------+-----------------------+--------------+
```