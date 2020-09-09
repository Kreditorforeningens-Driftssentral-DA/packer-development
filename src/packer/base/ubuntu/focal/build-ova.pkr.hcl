# Build virtualbox application
# packer build -only="ova.*" ./src/packer/base/ubuntu/focal
build {
  name    = "ova"
  sources = ["source.virtualbox-iso.bios"]

  provisioner "shell" {
    name             = "update-os"
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline           = [
      "sudo apt-get update",
      "sudo apt-get -qq -y upgrade",
    ]
  }

  provisioner "shell" {
    name             = "guest-additions-vbox"
    #only             = ["virtualbox-iso"]
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline           = [
      "sudo apt-get -qq -y install build-essential linux-headers-$(uname -r) dkms",
      "sudo mkdir -p /mnt/vbox",
      "sudo mount -o loop ./VBoxGuestAdditions.iso /mnt/vbox",
      "sudo /mnt/vbox/VBoxLinuxAdditions.run || echo \"VBoxLinuxAdditions.run exited $? and is suppressed. See https://www.virtualbox.org/ticket/12479\"",
      "sudo umount /mnt/vbox",
      "sudo rm -rf /mnt/vbox",
      "sudo rm -rf ./VBoxGuestAdditions.iso",
      "ls -lts",
    ]
  }
}

