---
sidebar_position: 2
---
# Python Backup Script With AWS S3 Integration
## MariaDB
```python title="MariaDB Backup" showLineNumbers
#crontab -l / crontab -e
#PATH=/usr/local/bin:/usr/bin:/bin
#PYTHONPATH=/usr/local/bin/python2.7
#
#30 18 * * 6 /usr/local/bin/python2.7 /root/backup/backup-script.py >> /root/backup/logfile.log 2>&1 18:30 every Saturday
#0 0 * * * /usr/lib/clamav-signatures/clam_scan.sh random

import os, subprocess, time, socket, smtplib, traceback
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication

#Path Configuration
hostname = socket.gethostname()
backup_file = time.strftime("%Y_%m_%d_") + socket.gethostname() + "_maria" + ".tar.bz2"
s3path = "s3://backups/users/zabbix/maria/" + backup_file

#Mail Configuration
mail_server = 'mailauth-server.net'
mail_login = 'mailauth'
mail_password = 'password'
sender = "backups@example.com"
receivers = ["andreas@blaze.com"]
port = 465

# Initialize size_mb to None
size_mb = None

# Run mariabackup to create a backup

backup_command = "mariabackup --user=root --backup --stream=xbstream |lbzip2 -n 6 -9 | s3cmd --server-side-encryption put - {} --multipart-chunk-size-mb=100 --stop-on-error".format(s3path)

backup_process = subprocess.Popen(backup_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
backup_output, backup_error = backup_process.communicate()

if backup_process.returncode != 0:
    # Backup failed
    status = "Backup failed with error: " + backup_error.strip()
    print("Backup failed with error: " + backup_error.strip())
    # Send error email here

else:
    # Backup succeeded
    status = "Backup and upload to s3 succeeded!"
    print("Backup and upload to s3 succeeded!")
    # Send success email here

# Compose email message
msg = MIMEMultipart()
msg['From'] = sender
msg['To'] = ", ".join(receivers)
msg['Subject'] = "MariaDB backup report for " + hostname

# Add email body text
if size_mb is not None:
    text = "Backup status: {}\nBackup size: {} MB".format(status, size_mb)
else:
    text = "Backup status: {}".format(status)
msg.attach(MIMEText(text, 'plain'))

# Get the traceback message
traceback_msg = traceback.format_exc()

# Add traceback message to email if there's an error
if "Traceback" in traceback_msg:
    text += "\n\nTraceback:\n{}".format(traceback_msg)
    msg.attach(MIMEText(text, 'plain'))

# Send email
server = smtplib.SMTP_SSL(mail_server, port)
try:
    server.login(mail_login, mail_password)
    server.sendmail(sender, receivers, msg.as_string())
    print("Email sent successfully")
except Exception as e:
    print("Error sending email: {}".format(str(e)))
finally:
    server.quit()

# Print status
print(status)
```
## PostgresDB
```python title="PostgresDB Backup" showLineNumbers
#crontab -l / crontab -e
#PATH=/usr/local/bin:/usr/bin:/bin
#PYTHONPATH=/usr/local/bin/python2.7
#
#30 18 * * 7 /usr/bin/python3 /root/backup/backup-script.py >> /root/backup/logfile.log 2>&1 (18:30 every Sunday)
#0 0 * * * /usr/lib/clamav-signatures/clam_scan.sh random

import os, subprocess, time, socket, smtplib, traceback
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication

#Path Configuration
hostname = socket.gethostname()
backup_file = time.strftime("%Y_%m_%d_") + socket.gethostname() + "_postgres" + ".tar.bz2"
s3path = "s3://backups/users/zabbix/postgres/" + backup_file

#Mail Configuration
mail_server = 'mailauth-server.net'
mail_login = 'mailauth'
mail_password = 'password'
sender = "backups@example.com"
receivers = ["andreas@blaze.com"]
port = 465

# Initialize size_mb to None
size_mb = None

# Run pg_basebackup to create a backup
backup_command = "pg_basebackup -Xf --format=tar -h localhost -U postgres -D - | lbzip2 -n 6 -9 | s3cmd --server-side-encryption put - {} --multipart-chunk-size-mb=100 --stop-on-error".format(s3path)

backup_process = subprocess.Popen(backup_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
backup_output, backup_error = backup_process.communicate()

if backup_process.returncode != 0:
    # Backup failed
    status = "Backup failed with error: " + backup_error.strip()
    print("Backup failed with error: " + backup_error.strip())
    # Send error email here

else:
    # Backup succeeded
    status = "Backup and upload to s3 succeeded!"
    print("Backup and upload to s3 succeeded!")
    # Send success email here

# Compose email message
msg = MIMEMultipart()
msg['From'] = sender
msg['To'] = ", ".join(receivers)
msg['Subject'] = "PostgresDB backup report for " + hostname

# Add email body text
if size_mb is not None:
    text = "Backup status: {}\nBackup size: {} MB".format(status, size_mb)
else:
    text = "Backup status: {}".format(status)
msg.attach(MIMEText(text, 'plain'))

# Get the traceback message
traceback_msg = traceback.format_exc()

# Add traceback message to email if there's an error
if "Traceback" in traceback_msg:
    text += "\n\nTraceback:\n{}".format(traceback_msg)
    msg.attach(MIMEText(text, 'plain'))

# Send email
server = smtplib.SMTP_SSL(mail_server, port)
try:
    server.login(mail_login, mail_password)
    server.sendmail(sender, receivers, msg.as_string())
    print("Email sent successfully")
except Exception as e:
    print("Error sending email: {}".format(str(e)))
finally:
    server.quit()

# Print status
print(status)
```