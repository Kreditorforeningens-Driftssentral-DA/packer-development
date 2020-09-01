build {
  sources = ["source.virtualbox-iso.ubuntu-bionic"]

  provisioner "shell" {
    inline = ["ls -lts /"]
  }
}