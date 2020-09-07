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

  post-processor "vagrant" {
    keep_input_artifact = false
    provider_override   = "virtualbox"
    output              = "./output/vagrant/{{.Provider}}-hashicluster.box"
  }
}
