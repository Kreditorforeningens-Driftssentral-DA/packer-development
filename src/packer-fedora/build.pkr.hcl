build {
  sources = [
    "source.virtualbox-iso.focal",
    "source.virtualbox-iso.focal-legacy"
  ]

  provisioner "shell" {
    inline = ["ls -lts /"]
  }
}