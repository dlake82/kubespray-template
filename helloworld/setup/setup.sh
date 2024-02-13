vagrant plugin install vagrant-hostmanager
vagrant plugin install virtualbox_WSL2

vagrant up --provider virtualbox

sudo apt update
sudo apt upgrade
sudo apt install python3 python3-pip git -y

# ip4 포워딩
sudo vim /etc/sysctl.conf
# net.ipv4.ip_forward = 1 주석 해제

sudo sysctl -p /etc/sysctl.conf
sudo service network restart
cat /proc/sys/net/ipv4/ip_forward

# 방화벽 해제 및 스왑 메모리 해제
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo swapoff -a

# kubeconfig 가져옴
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# capacity 0 warning 제거
systemctl restart containerd
systemctl restart kubelet