#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

echo "Download images ..will take time.."
echo "via .. kubeadm config images pull"
echo "
Pulling Below Config/images
registry.k8s.io/kube-apiserver
registry.k8s.io/kube-controller-manager
registry.k8s.io/kube-scheduler
registry.k8s.io/kube-proxy
registry.k8s.io/coredns/coredns
registry.k8s.io/pause
registry.k8s.io/etcd
";
kubeadm config images pull
