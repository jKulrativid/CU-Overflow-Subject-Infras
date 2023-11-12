sudo hostnamectl set-hostname worker-x

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

echo { \"exec-opts\" : [ \"native.cgroupdriver=systemd\" ] } | sudo tee /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart kubelet
