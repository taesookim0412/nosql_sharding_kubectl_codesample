#https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

sudo apt upgrade -y

sudo apt install docker.io -y

docker ––version

sudo systemctl enable docker

sudo systemctl start docker

# sudo systemctl status docker

sudo systemctl start docker

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

sudo apt-add-repository "deb http://packages.cloud.google.com/apt/ kubernetes-xenial main"

yes | sudo apt-get install kubeadm kubelet kubectl

sudo apt-mark hold kubeadm kubelet kubectl

kubeadm version

swapoff –a

sudo hostnamectl set-hostname master-node

sudo hostnamectl set-hostname w1

# install weave
sudo curl -L git.io/weave -o /usr/local/bin/weave
sudo chmod a+x /usr/local/bin/weave
export CHECKPOINT_DISABLE=1


sudo weave launch
sudo weave env
sudo docker run --name a1 -ti weaveworks/ubuntu

sudo kubeadm init --pod-network-cidr=10.0.0.0/24

mkdir -p $HOME/.kube
yes | sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#sudo systemctl restart kubelet

kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

kubectl label nodes w1 size=large


export KUBECONFIG=$HOME/.kube/config


# might have to run this again.
mkdir -p $HOME/.kube
yes | sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


