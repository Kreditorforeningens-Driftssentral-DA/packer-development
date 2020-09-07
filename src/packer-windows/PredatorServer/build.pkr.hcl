build {
  name = "base"
  sources = [
    "source.virtualbox-iso.w2k19",
  ]
}

build {
  name = "customize"
  sources = ["source.null.post-build"]
  provisioner "" {}
}