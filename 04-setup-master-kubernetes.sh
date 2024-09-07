#!/bin/bash

## only for custom
#podnetwork="11.11.0.0/16"
#servicenetwork="12.10.4.0/24"
#masterhost="10.10.4.116"

#sed -i "s#11.85.0.0/16#$podnetwork#g" /etc/cni/net.d/11-crio-ipv4-bridge.conflist 

export KUBECONFIG=/etc/kubernetes/admin.conf

#use root instand of ks8adminuser
#useradd ks8adminuser
#chsh -s /bin/bash ks8adminuser

# These address ranges are examples

# only for custom
#kubeadm init --pod-network-cidr=$podnetwork --service-cidr=$servicenetwork --control-plane-endpoint=$masterhost --cri-socket=unix:///var/run/crio/crio.sock

kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket=unix:///var/run/crio/crio.sock 

#sleep for init to finish
sleep 10
mkdir -p /root/.kube
/bin/cp -pRv /etc/kubernetes/admin.conf /root/.kube/config
chown -R root:root /root/.kube

#su -c 'kubectl get nodes' ks8adminuser
kubectl get nodes

kubectl create -f files/calico-network/tigera-operator.yaml
/bin/cp files/calico-network/custom-resources.yaml /tmp/custom-resources.yaml

#only for custom
#sed -i "s#11.244.0.0/16#$podnetwork#g" /tmp/custom-resources.yaml

kubectl create -f /tmp/custom-resources.yaml

## show CALICO System
kubectl get pods -n calico-system
## show KUBE System
kubectl get pods -n kube-system


