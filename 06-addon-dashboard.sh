#!/bin/bash

## DNS to check
#https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/

export KUBECONFIG=/etc/kubernetes/admin.conf

#https://github.com/kubernetes/dashboard#kubernetes-dashboard
# Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
# Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

kubectl -n kubernetes-dashboard get all
kubectl get pods -A -owide

#create admin for dashboard
kubectl create -f files/dashboard-admin.yaml

#create token
kubectl create -f files/dashboard-user-token.yaml
#or
kubectl create token dashboard-admin --namespace kubernetes-dashboard