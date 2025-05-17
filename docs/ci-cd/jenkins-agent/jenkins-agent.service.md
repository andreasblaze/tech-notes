# /etc/systemd/system/jenkins-agent.service
```bash
[Unit]
Description=Jenkins agent

[Service]
Type=simple
ExecStart=/usr/bin/java -jar /root/agent.jar -url <URL> -secret <SECRET> -name <HOST_NAME> -workDir /home/jenkins -webSocket
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```
## Reload systemd and restart the service
```bash
systemctl daemon-reexec
```
```bash
systemctl daemon-reload
```
```bash
systemctl restart jenkins-agent
```
## Watch logs live
```bash
journalctl -u jenkins-agent -f
```