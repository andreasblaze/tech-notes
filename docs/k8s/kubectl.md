---
sidebar_position: 2
---

# kubectl

## kubectl get
```bash
kubectl get nodes
```
OR
```bash
kubectl get pods/deployments/svc/events/networkpolicy -n <namespace> #OR --all-namespaces
```
Get a list of items in JSON:
```bash
kubectl get deployments/daemonset/sts -n sre-monitoring -o json | jq '.items[].spec.template.spec.containers[] | {name: .name, requests: .resources.requests, limits: .resources.limits}'
```

## kubectl describe
```bash
kubectl describe pod/svc <service-name> -n <namespace>
```
- Verify the Updated DaemonSet
```bash
kubectl describe daemonset cadvisor -n utils
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

## kubectl top
```bash
kubectl top <node-name>
```
```bash
kubectl top <pod-name> -n <namespace> #can be used with --containers
```

## kubectl edit
- Manually Edit the DaemonSet (if necessary)
```bash
kubectl edit daemonset cadvisor -n utils
```