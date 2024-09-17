---
sidebar_position: 3
---

```jsx title="~/.kube/config"
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: 

    *****

    server: https://*****.gr7.us-west-2.eks.amazonaws.com
  name: arn:aws:eks:us-west-2:*****:cluster/cluster-monitoring
- cluster:
    certificate-authority-data: 

    *****

    server: https://api.prod.net:443
  name: production
- cluster:
    certificate-authority-data: 

    *****

    server: https://api.sandbox.net:443
  name: sandbox
- cluster:
    certificate-authority-data: 

    *****

    server: https://api.server-2.net:443
  name: prometheus
contexts:
- context:
    cluster: arn:aws:eks:us-west-2:*****:cluster/cluster-monitoring
    user: arn:aws:eks:us-west-2:*****:cluster/cluster-monitoring
  name: arn:aws:eks:us-west-2:*****:cluster/cluster-monitoring
- context:
    cluster: production
    user: production
  name: production
- context:
    cluster: sandbox
    user: sandbox
  name: sandbox
- context:
    cluster: prometheus
    user: prometheus
  name: prometheus
current-context: prometheus
kind: Config
preferences: {}
users:
- name: arn:aws:eks:us-west-2:*****:cluster/cluster-monitoring
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - --region
      - us-west-2
      - eks
      - get-token
      - --cluster-name
      - cluster-monitoring
      - --output
      - json
      command: aws
      env:
      - name: AWS_PROFILE
        value: Admin-*****
      interactiveMode: IfAvailable
      provideClusterInfo: false
- name: production
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - oidc-login
      - get-token
      - --oidc-issuer-url=https://auth.service.com/adfs
      - --oidc-client-id=*****
      - --oidc-client-secret=*****
      command: kubectl
      env: null
      interactiveMode: IfAvailable
      provideClusterInfo: true
- name: sandbox
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - oidc-login
      - get-token
      - --oidc-issuer-url=https://auth.service.com/adfs
      - --oidc-client-id=*****
      - --oidc-client-secret=*****
      command: kubectl
      env: null
      interactiveMode: IfAvailable
      provideClusterInfo: true
- name: prometheus
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - oidc-login
      - get-token
      - --oidc-issuer-url=https://auth.service.com/adfs
      - --oidc-client-id=*****
      - --oidc-client-secret=*****
      command: kubectl
      env: null
      interactiveMode: IfAvailable
      provideClusterInfo: true
```