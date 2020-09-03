build {
  sources = [
    "source.virtualbox-iso.focal-live",
    "source.virtualbox-iso.bionic-live",
    "source.virtualbox-iso.focal-legacy",
    "source.virtualbox-iso.bionic-legacy"
  ]

  provisioner "shell" {
    inline = ["cat /etc/issue.net","hostname -I"]
  }
}