# Example: packer build -force -only="base.virtualbox-iso.focal-bios" ./src/packer/base/ubuntu/focal\
build {
  name    = "base"
  sources = ["source.virtualbox-iso.focal-bios"]

  provisioner "breakpoint" {
    disable = true
    note    = "Before Virtualbox Guest Additions installation"
  }

  provisioner "shell" {
    name = "guest-additions"
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "sudo apt-get update",
      "sudo apt-get -qq -y install build-essential linux-headers-$(uname -r) dkms",
      "sudo mkdir -p /mnt/vbox",
      "sudo mount -o loop ./VBoxGuestAdditions.iso /mnt/vbox",
      "sudo /mnt/vbox/VBoxLinuxAdditions.run || echo \"VBoxLinuxAdditions.run exited $? and is suppressed.\"", # https://www.virtualbox.org/ticket/12479
      "sudo umount /mnt/vbox",
      "sudo rm -rf /mnt/vbox",
      "sudo rm -rf ./VBoxGuestAdditions.iso",
    ]
  }

  post-processor "vagrant" {
    output              = "./builds/vagrant/{{.Provider}}_ubuntu_{{.BuildName}}.box"
    keep_input_artifact = true
    compression_level   = 9
    provider_override   = "virtualbox"
  }
}
