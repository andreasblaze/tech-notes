## Step 1: Install krew
```bash
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed 's/x86_64/amd64/' | sed 's/arm.*$/arm/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```
```bash
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
```
```bash
source ~/.bashrc
```
## Step 2: Install the oidc-login Plugin
```bash
kubectl krew install oidc-login
```