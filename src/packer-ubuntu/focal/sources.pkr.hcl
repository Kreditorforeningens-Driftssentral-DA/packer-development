# ===================================================================
#  UBUNTU 20.04 -- Subiquity
# ===================================================================

source "virtualbox-iso" "focal-live" {
  skip_export = true
  headless    = false

  # SOURCE
  iso_target_path = "./src/_images"
  iso_checksum    = "file:http://releases.ubuntu.com/focal/SHA256SUMS"
  iso_urls        = [
    "./src/_images/ubuntu-20.04.1-live-server-amd64.iso",
    "http://releases.ubuntu.com/focal/ubuntu-20.04.1-live-server-amd64.iso",
  ]

  # COMPUTER SETTINGS
  vm_name       = "packer-focal-live"
  guest_os_type = "Ubuntu_64"
  iso_interface = "sata"
  disk_size     = "8000"
  vboxmanage    = [
    ["modifyvm", "{{ .Name }}", "--firmware", "BIOS"],
    ["modifyvm", "{{ .Name }}", "--cpus", "1"],
    ["modifyvm", "{{ .Name }}", "--memory", "1024"],
  ]

  # DEPLOYMENT SETTINGS
  http_directory         = "./src/_http/subiquity/ubuntu-20.04"
  boot_wait              = "5s"
  boot_keygroup_interval = "500ms"
  boot_command           = [
    "<wait><enter>", # Stop autoboot
    "<wait5><enter>", # Select language
    "<f6><wait3><esc><wait3>", # Open default boot-command for appending info
    "autoinstall <wait>ds=nocloud-net;<wait>s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/<spacebar><wait>", # Trailing slash is important
    "<enter>" # Execute command
  ]

  shutdown_command = "echo 'packer' | shutdown -P now"
  shutdown_timeout = "30m"

  # PROVISIONING SETTINGS
  communicator           = "ssh"
  ssh_username           = "packer"
  ssh_password           = "packer"
  ssh_pty                = true
  ssh_handshake_attempts = 30
  ssh_timeout            = "10m"
}


## ===================================================================
##  UBUNTU 20.04 -- Debian Installer (Legacy)
## ===================================================================

source "virtualbox-iso" "focal-legacy" {
  headless    = false
  skip_export = true

  # SOURCE
  iso_target_path = "./src/_images"
  iso_checksum    = "file:http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04.1/release/SHA256SUMS"
  iso_urls        = [
    "./src/_images/ubuntu-20.04.1-legacy-server-amd64.iso",
    "http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release/ubuntu-20.04.1-legacy-server-amd64.iso",
  ]

  # COMPUTER SETTINGS
  vm_name       = "packer-focal-legacy"
  guest_os_type = "Ubuntu_64"
  iso_interface = "sata"
  disk_size     = "8000"
  vboxmanage    = [
    ["modifyvm", "{{ .Name }}", "--firmware", "BIOS"],
    ["modifyvm", "{{ .Name }}", "--memory", "1024"],
    ["modifyvm", "{{ .Name }}", "--cpus", "1"]
  ]

  # DEPLOYMENT SETTINGS
  http_directory         = "./src/_http/debian-installer/ubuntu-20.04"
  boot_wait              = "10s"
  boot_keygroup_interval = "500ms"
  boot_command           = [
    "<esc><wait5>",   # Interrupt automatic boot
    "<esc><wait5>",   # Close dialog
    "<enter><wait5>", # Confirm opening text-console
    "/install/vmlinuz<spacebar><wait>",
    "initrd=<wait>/install/initrd.gz<spacebar><wait>",
    "auto-install/enable=<wait>true<spacebar><wait>", # Delays the locale and keyboard questions until after there has been a chance to preseed them
    "debconf/priority=<wait>critical<spacebar><wait>", # Stops any questions with a lower priority from being asked
    "preseed/url=<wait>http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<spacebar><wait>", # Location of preseed.cfg
    "--- <wait><enter>" # Anything that is passed after the '---' are appended to the default options for the installed system; everything before the '--' is only used by the installer itself.
  ]

  shutdown_command = "echo 'packer' | sudo shutdown -P now"
  shutdown_timeout = "30m"

  # CONNECTION SETTINGS
  communicator = "ssh"
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_timeout  = "30m"
  ssh_pty      = true
  ssh_port     = 22
}
