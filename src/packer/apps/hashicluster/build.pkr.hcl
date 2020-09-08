# Example: packer build -force -only="nomad.virtualbox-ovf.hashicorp" .\src\packer-ubuntu\focal\
build {
  name    = "hashicluster"
  sources = ["source.virtualbox-ovf.focal-hashicluster"]

  provisioner "shell" {
    name = "update"
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y -qq upgrade",
    ]
  }

  provisioner "shell" {
    name = "repo"
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -",
      "sudo apt-add-repository \"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main\"",
      "sudo apt-get update",
    ]
  }

  provisioner "shell" {
    name = "install"
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "sudo apt-get -y -qq install consul nomad vault",
    ]
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    provider_override   = "virtualbox"
    output              = "./output/vagrant/{{.Provider}}-hashicluster.box"
  }
}
