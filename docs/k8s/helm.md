---
sidebar_position: 1
---
# Helm

## Deploy Helm Chart inside cluster
- Add the Helm Repository: If you haven’t already added the Helm repository, run the following command to add it:
```bash
helm repo add ckotzbauer https://ckotzbauer.github.io/helm-charts
helm repo update
```
- Customize Values (Optional):
```yaml
daemonset:
  enabled: true
  args:
    - --housekeeping_interval=30s
    - --disable_metrics=disk
    - --enable_metrics=tcp,udp
resources:
  limits:
    cpu: 100m
    memory: 200Mi
```
- Deploy the Helm Chart with modificated *values.yaml*:
```bash
helm install cadvisor ckotzbauer/cadvisor --namespace utils -f values.yaml
```
- Verify the Deployment:
```bash
kubectl get daemonset -n utils
kubectl logs daemonset/cadvisor -n utils
```