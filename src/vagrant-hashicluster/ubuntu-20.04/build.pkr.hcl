build {
  sources = ["source.virtualbox-iso.ubuntu-focal"]

  provisioner "shell" {
    inline = ["ls -lts /"]
  }
}