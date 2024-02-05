# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  $vm_provider = "virtualbox"
  $box_image = "ubuntu/jammy64"
  $vm_name_prefix = "kube"
  $number_of_control_planes = 1
  $number_of_nodes = 3
  $vm_subnet = "192.168.56"
  $vm_control_plane_cpus = 2
  $vm_control_plane_memory = 3072
  $vm_node_cpus = 2
  $vm_node_memory = 2560
  # Kubernetes Control Planes
  (1..$number_of_control_planes).each do |i|
    config.vm.define "#{$vm_name_prefix}-control#{i}" do |node|
      node.vm.box = $box_image
      node.vm.provider $vm_provider do |vm|
        vm.name = "#{$vm_name_prefix}-control#{i}"
        vm.cpus = $vm_control_plane_cpus
        vm.memory = $vm_control_plane_memory
      end
      node.vm.hostname = "#{$vm_name_prefix}-control#{i}"
      node.vm.network "private_network", ip: "#{$vm_subnet}.1#{i}", nic_type: "virtio"
    end
  end
  # Kubernetes Nodes
  (1..$number_of_nodes).each do |i|
    config.vm.define "#{$vm_name_prefix}-node#{i}" do |node|
      node.vm.box = $box_image
      node.vm.provider $vm_provider do |vm|
        vm.name = "#{$vm_name_prefix}-node#{i}"
        vm.cpus = $vm_node_cpus
        vm.memory = $vm_node_memory
      end
      node.vm.hostname = "#{$vm_name_prefix}-node#{i}"
      node.vm.network "private_network", ip: "#{$vm_subnet}.2#{i}", nic_type: "virtio"
    end
  end
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
    # Basebox ubuntu/xenial64 comes with following Vagrantfile config and causes https://github.com/joelhandwell/ubuntu_vagrant_boxes/issues/1
    # vb.customize [ "modifyvm", :id, "--uart1", "0x3F8", "4" ]
    # vb.customize [ "modifyvm", :id, "--uartmode1", "file", File.join(Dir.pwd, "ubuntu-xenial-16.04-cloudimg-console.log") ]
    # following config will address the issue
    v.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
  end
  # Change APT Repository & Enable SSH Password Authentication
  config.vm.provision "shell", inline: <<-SHELL
    sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
    sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    systemctl restart ssh
  SHELL
end
