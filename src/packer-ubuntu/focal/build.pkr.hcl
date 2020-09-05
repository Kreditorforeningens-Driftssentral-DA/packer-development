# Example: packer build -force -only="base.virtualbox-iso.focal-bios" .\src\packer-ubuntu\focal\
build {
  name    = "base"
  sources = ["source.virtualbox-iso.focal-bios"]
}

# Example: packer build -force -only="nomad.virtualbox-ovf.hashicorp" .\src\packer-ubuntu\focal\
build {
  name    = "hashicorp"
  sources = ["source.virtualbox-ovf.focal-hashicorp"]

  provisioner "shell" {
    name = "install-docker"
    inline = [
      "sudo apt-get update",
      "sudo apt-get -qqy upgrade",
      "curl -fsSL get.docker.com | bash",
      "sudo usermod -aG docker $USER",
    ]
  }
}
