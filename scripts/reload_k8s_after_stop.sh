sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart kubelet

sudo systemctl enable kubelet

## If not work
sudo -i
swapoff -a
exit
strace -eopenat kubectl version
