1. Below the script yo install kind and kubectl : <br>
  - first create a kind name folder using "mkdir kind" after that "cd kind"
  - after that create file using vim install-kind.sh chmod +x install-kind.sh
  - run using sudo bash install-kind.sh
  - pls refer for latest kind and kubectl version
  - kind : https://kind.sigs.k8s.io/docs/user/quick-start#installation

```bash

#!/bin/bash

[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo cp ./kind /usr/local/bin/kind

VERSION="v1.30.0"
URL="https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
INSTALL_DIR="/usr/local/bin"

curl -LO "$URL"
chmod +x kubectl
sudo mv kubectl $INSTALL_DIR/
kubectl version --client

rm -f kubectl
rm -rf kind

echo "kind & kubectl installation complete."
```