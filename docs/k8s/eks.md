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
aws eks update-kubeconfig --region <region> --name <cluster-name> --profile <profile-name> #`--profile` to resolve Lens issue
```