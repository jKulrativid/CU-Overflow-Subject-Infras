## Install Basics
sudo apt update
sudo apt upgrade openssl -y
sudo apt install nfs-common -y
sudo apt install make -y

## Install Kubernetes
sudo hostnamectl set-hostname master

sudo apt-get update

sudo apt-get install -y apt-transport-https gnupg2

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo deb https://apt.kubernetes.io/ kubernetes-xenial main | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubectl kubeadm kubelet kubernetes-cni docker.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER

newgrp docker

cat << EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

sudo kubeadm config images pull

echo { \"exec-opts\" : [ \"native.cgroupdriver=systemd\" ] } | sudo tee /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart kubelet

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

## Install Docker Compose
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

## Install Helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

## Install Helm Dashboard
helm plugin install https://github.com/komodorio/helm-dashboard.git

## Create Join Worker Nodes Command
kubeadm token create --print-join-command
## And copy printed command then run on worker nodes

## Run Helm Dashboard
helm dashboard --no-browser --bind=0.0.0.0

## Allow Master Node Deployment
# kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule
