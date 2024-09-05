# k8s-ubuntu
Kubernetes setup on Ubuntu 24.04 LTS

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config



Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join 10.10.4.116:6443 --token 2vs71g.i4dkfbv7ajekk774 \
        --discovery-token-ca-cert-hash sha256:aaa24632137124cb1bf60e6db0163dbce7bfd74695a3a41ab969a39418f4336a \
        --control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 10.10.4.116:6443 --token 2vs71g.i4dkfbv7ajekk774 --discovery-token-ca-cert-hash sha256:aaa24632137124cb1bf60e6db0163dbce7bfd74695a3a41ab969a39418f4336a

scp .kube/config to all node 
scp /etc/cni/net.d/ to all node		
		
		
NOTES:
*************************************************************************************************
*** PLEASE BE PATIENT: Kubernetes Dashboard may need a few minutes to get up and become ready ***
*************************************************************************************************

Congratulations! You have just installed Kubernetes Dashboard in your cluster.

To access Dashboard run:
  kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443

NOTE: In case port-forward command does not work, make sure that kong service name is correct.
      Check the services in Kubernetes Dashboard namespace using:
        kubectl -n kubernetes-dashboard get svc

Dashboard will be available at:
  https://localhost:8443		
  
  
  
  
