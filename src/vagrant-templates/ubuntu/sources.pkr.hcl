#                   _
#   __ _ _ __   ___| |__   ___  _ __ ___
#  / _` | '_ \ / __| '_ \ / _ \| '__/ __|
# | (_| | | | | (__| | | | (_) | |  \__ \
#  \__,_|_| |_|\___|_| |_|\___/|_|  |___/
#
source "hyperv-iso" "ubuntu-focal" {
  vm_name = "ubuntu-focal"
  # --
  iso_target_path = "./images"
  iso_checksum    = "sha256:443511f6bf12402c12503733059269a2e10dec602916c0a75263e5d990f6bb93"
  iso_urls        = [
    "./images/ubuntu-20.04.1-live-server-amd64.iso",
    "http://ubuntu.uib.no/releases/focal/ubuntu-20.04.1-live-server-amd64.iso"
  ]
  # --
  headless                         = false
  enable_dynamic_memory            = false
  differencing_disk                = true
  enable_secure_boot               = false
  guest_additions_mode             = "disable"
  #enable_virtualization_extensions = false
  # --
  generation   = 2
  cpus         = 2
  memory       = 768
  disk_size    = 16000
  # --
  switch_name    = "Default Switch"
  http_directory = "./http/subiquity"
  # --
  communicator = "ssh"
  ssh_port     = 22
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_timeout  = "30m"
  # --
  boot_wait      = "5s"
  boot_command   = [
    "<enter><enter><f6><esc><wait>",
    " autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter><wait>"
  ]
  # --
  shutdown_command = "sudo shutdown -P now"
  shutdown_timeout = "20m"
}

source "hyperv-iso" "ubuntu-focal-legacy" {
  vm_name = "ubuntu-focal-legacy"
  # --
  iso_target_path = "./images"
  iso_checksum = "sha256:f11bda2f2caed8f420802b59f382c25160b114ccc665dbac9c5046e7fceaced2"
  #iso_checksum = "sha256:36f15879bd9dfd061cd588620a164a82972663fdd148cce1f70d57d314c21b73"
  iso_urls      = [
    "./images/ubuntu-20.04.1-legacy-server-amd64.iso", # f11bda2f2caed8f420802b59f382c25160b114ccc665dbac9c5046e7fceaced2
    "http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release/ubuntu-20.04.1-legacy-server-amd64.iso",
    #"./images/ubuntu-20.04-legacy-server-amd64.iso", # 36f15879bd9dfd061cd588620a164a82972663fdd148cce1f70d57d314c21b73
    #"http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release/ubuntu-20.04-legacy-server-amd64.iso"
    ]
  # --
  headless                         = false
  enable_dynamic_memory            = true
  differencing_disk                = true
  enable_secure_boot               = false
  enable_virtualization_extensions = false
  guest_additions_mode             = "disable"
  # --
  generation   = 1
  cpus         = 2
  memory       = 768
  disk_size    = 10000
  # --
  switch_name    = "Default Switch"
  http_directory = "./http/debian-installer"
  # --
  communicator = "ssh"
  ssh_pty      = true
  ssh_port     = 22
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_timeout  = "30m"
  # --
  boot_wait      = "5s"
  boot_command   = [
    "<esc><wait>",
    "<esc><wait>",
    "<enter><wait>",
    "/install/vmlinuz<wait>",
    " initrd=/install/initrd.gz",
    " auto-install/enable=true",
    " debconf/priority=critical",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/hyperv.cfg<wait>",
    " -- <wait>",
    "<enter><wait>"
  ]
  # --
  shutdown_command = "sudo shutdown -P now"
  shutdown_timeout = "30m"
}
