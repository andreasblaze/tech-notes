---
sidebar_position: 5
---
# EKS

## Access
export creds from aws
use-context
aws eks update-kubeconfig --region us-west-2 --name production-1
kubectl logs -f alertmanager-kube-prometheus-stack-0 -n kube-prometheus-stack

aws eks update-kubeconfig --region us-west-2 --name production-1 --profile SRE_Shift-PR-View-727594095862
to resolve Lens issue
SRE_Shift-PR-View-727594095862