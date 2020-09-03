build {
  sources = [
    "source.virtualbox-iso.focal-live",
    "source.virtualbox-iso.focal-legacy",
  ]

  provisioner "shell" {
    inline = ["cat /etc/issue.net","hostname -I"]
  }
}