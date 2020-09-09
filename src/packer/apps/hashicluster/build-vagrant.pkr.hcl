build {
  name    = "ubuntu"
  sources = ["source.virtualbox-ovf.ubuntu"]

  # Install required packages
  provisioner "shell" {
    name             = "PreReq"
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline           = [
      "sudo apt-get -qq -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common",
    ]
  }

  # Install docker packages
  provisioner "shell" {
    name             = "Docker-Install"
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=true",
    ]
    inline           = [
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo apt-add-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get -qq -y install docker-ce docker-ce-cli containerd.io",
      "sudo usermod -aG docker $USER",
      "sudo systemctl restart docker",
    ]
  }

  # Install KVM-QEMU
  provisioner "shell" {
    name             = "KVM-Install"
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=true",
    ]
    inline           = [
      "sudo apt-get -qq -y install qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager",
      "sudo systemctl start libvirtd",
    ]
  }

  # Install CNI-plugins
  provisioner "shell" {
    name             = "CNI-Install"
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=true",
    ]
    inline           = [
      "curl -L -o cni-plugins.tgz https://github.com/containernetworking/plugins/releases/download/v0.8.6/cni-plugins-linux-amd64-v0.8.6.tgz",
      "sudo mkdir -p /opt/cni/bin",
      "sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz",
      "sudo tee -a /etc/sysctl.d/cni-plugins > /dev/null <<EOF",
      "net.bridge.bridge-nf-call-arptables = 1",
      "net.bridge.bridge-nf-call-ip6tables = 1",
      "net.bridge.bridge-nf-call-iptables = 1",
      "EOF",
    ]
  }

  # Install HashiCorp packages
  provisioner "shell" {
    name             = "HashiCluster-Install"
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=true",
    ]
    inline           = [
      "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -",
      "sudo apt-add-repository \"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main\"",
      "sudo apt-get update",
      "sudo apt-get -qq -y install consul vault nomad",
      "sudo tee -a /etc/consul.d/consul.hcl < /dev/null <<EOH",
      "server    = true",
      "bootstrap = true",
      "bind_addr = \"\\{\\{ GetInterfaceIP \"enp0s3\" \\}\\}\"",
      "ports   { grpc = 8502 }",
      "connect { enabled = true }",
      "EOH",
      "sudo systemctl enable consul",
      "sudo systemctl enable vault",
      "sudo systemctl enable nomad",
      "sudo systemctl start consul",
      "sudo systemctl start vault",
      "sudo systemctl start nomad",
    ]
  }

  # Export local vagrant-box
  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "${local.build_folder}/hashicluster_{{.Provider}}.box"
    compression_level   = 9
    }
}