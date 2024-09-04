#!/bin/bash

CRIO_VERSION=v1.30
KUBERNETES_VERSION=v1.31

export KUBECONFIG=/etc/kubernetes/admin.conf

curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/stable:/$CRIO_VERSION/deb/Release.key |
    gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/stable:/$CRIO_VERSION/deb/ /" |
    tee /etc/apt/sources.list.d/cri-o.list


curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key |
    gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /" |
    tee /etc/apt/sources.list.d/kubernetes.list

apt-get update

apt-get install -y cri-o kubelet kubeadm kubectl rsyslog-kubernetes

## check and print version
kubectl version --client

# below command firs time would gert error
# The connection to the server <server-name:port> was refused - did you specify the right host or port?
#kubectl cluster-info dump

# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
# Enable kubectl autocompletion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
sudo chmod a+r /etc/bash_completion.d/kubectl
source ~/.bashrc

systemctl start crio.service

#https://kubernetes.io/docs/setup/production-environment/container-runtimes/#cri-o
#Kubernetes requires the following configurations be set before using cri-o container runtime
modprobe overlay
modprobe br_netfilter
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

## download calico ctl before config
cd /tmp/
curl -L https://github.com/projectcalico/calico/releases/download/v3.28.0/calicoctl-linux-amd64 -o kubectl-calico
chmod +x kubectl-calico
/bin/cp -p /tmp/kubectl-calico /usr/bin/
cd -
#kubectl calico -h


