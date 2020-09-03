build {
  sources = [
    "source.virtualbox-iso.w2k19core-efi",
  ]

  provisioner "powershell" {
    inline = ["dir c:\\ "]
  }
}