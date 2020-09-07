# Example: packer build -force -only="base.virtualbox-iso.focal-bios" .\src\packer-ubuntu\focal\
build {
  name    = "base"
  sources = ["source.virtualbox-iso.focal-bios"]
}
