---
sidebar_position: 5
---
# EKS

## Access
```bash
kubectl get-contexts
```
```bash
kubectl use-context
```
```bash
aws configure sso
```
Export creds from AWS
```bash
aws eks update-kubeconfig --region <region> --name <cluster-name> --profile <profile-name>
```

## Migrate pods from one node to another
```bash
kubectl get nodes -o wide
```
```bash
kubectl get nodes -l eks.amazonaws.com/nodegroup=<name>
```
```bash
kubectl cordon -l eks.amazonaws.com/nodegroup=<name>
```