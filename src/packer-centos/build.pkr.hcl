build {
  sources = [
    "source.virtualbox-iso.centos-8-bios",
  ]

  provisioner "shell" {
    inline = ["cat /etc/issue.net","hostname -I"]
  }
}