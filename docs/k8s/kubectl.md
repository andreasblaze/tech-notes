---
sidebar_position: 2
---

# kubectl

## kubectl get nodes
```bash
kubectl get nodes
```
## kubectl get pods
```bash
kubectl get pods --all-namespaces
```
```bash
kubectl get pods -n <namespace>
```
## kubectl get services
```bash
kubectl get svc -n <namespace>
```
## kubectl get svc
```bash
kubectl get svc
```
## kubectl get events
```bash
kubectl get events
```

## kubectl describe
```bash
kubectl describe svc <service-name> -n <namespace>
```
- Verify the Updated DaemonSet
```bash
kubectl describe daemonset cadvisor -n utils
```

```bash
kubectl describe pod
```

## kubectl get networkpolicy
```bash
kubectl get networkpolicy -n <namespace>
```
## kubectl logs
```bash
kubectl logs <pod-name> -n <namespace>
```
real-time monitoring:
```bash
kubectl logs -f <pod-name> -n <namespace>
```
View Logs for a Specific Container in the Pod:
```bash
kubectl logs <pod-name> -c <container-name> -n <namespace>
```
Filter Logs for Errors:
```bash
kubectl logs <pod-name> -n <namespace> | grep -i error
```
## kubectl exec
Exec into the Pod:
```bash
kubectl exec -it <pod-name> -n <namespace> -- /bin/bash
```
## kubectl apply
```bash
kubectl apply -f <policy-file>.yaml
```
```bash

```
## kubectl top node
```bash
kubectl top node
```

## kubectl top pod
```bash
kubectl top pod
```

## kubectl edit
- Manually Edit the DaemonSet (if necessary)
```bash
kubectl edit daemonset cadvisor -n utils
```