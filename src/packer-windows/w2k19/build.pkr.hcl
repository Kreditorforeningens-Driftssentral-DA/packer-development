build {
  name = "isobuild"
  sources = [
    "source.virtualbox-iso.w2k19core-bios",
  ]
}

build {
  name = "customize"
  sources = ["source.null.post-build"]
  provisioner "" {}
}