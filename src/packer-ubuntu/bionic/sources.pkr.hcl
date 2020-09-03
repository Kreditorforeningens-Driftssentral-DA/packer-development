# ===================================================================
#  UBUNTU 18.04 -- Subiquity
# ===================================================================

source "virtualbox-iso" "bionic-live" {
  headless    = false
  skip_export = true
  
  # SOURCE
  iso_target_path = "./src/_images"
  iso_checksum    = "file:http://releases.ubuntu.com/bionic/SHA256SUMS"
  iso_urls        = [
    "./src/_images/ubuntu-18.04.5-live-server-amd64.iso",
    "http://releases.ubuntu.com/bionic/ubuntu-18.04.5-live-server-amd64.iso",
  ]

  # COMPUTER SETTINGS
  vm_name       = "packer-bionic-live"
  guest_os_type = "Ubuntu_64"
  iso_interface = "sata"
  disk_size     = "8000"
  vboxmanage    = [
    ["modifyvm", "{{ .Name }}", "--firmware", "BIOS"],
    ["modifyvm", "{{ .Name }}", "--cpus", "1"],
    ["modifyvm", "{{ .Name }}", "--memory", "1024"],
  ]

  # DEPLOYMENT SETTINGS
  http_directory         = "./src/_http/subiquity/ubuntu-18.04"
  boot_wait              = "5s"
  boot_keygroup_interval = "500ms"
  boot_command           = [
    "<wait><enter>", # Stop autoboot
    "<wait5><enter>", # Select language
    "<f6><wait3>", #Open default boot-command
    "<esc><wait3>", # Close dialog for appending info
    "autoinstall ds=nocloud-net;<wait3>", # Input autoboot parameters
    "s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/<spacebar><wait3>", # Trailing slash is important
    "--- <enter>" # Execute boot

  ]

  shutdown_command = "shutdown -P now"
  shutdown_timeout = "30m"

  # CONNECTION SETTINGS
  communicator           = "ssh"
  ssh_username           = "packer"
  ssh_password           = "packer"
  ssh_timeout            = "30m"
  ssh_pty                = true
}

# ===================================================================
#  UBUNTU 18.04 -- debian-installer (legacy)
# ===================================================================

source "virtualbox-iso" "bionic-legacy" {
  headless    = false
  skip_export = true

  # SOURCE
  iso_target_path = "./src/_images"
  iso_checksum    = "file:http://releases.ubuntu.com/bionic/SHA256SUMS"
  iso_urls        = [
    "./src/_images/ubuntu-18.04.5-server-amd64.iso",
    "https://cdimage.ubuntu.com/releases/18.04.5/release/ubuntu-18.04.5-server-amd64.iso",
  ]

  # COMPUTER SETTINGS
  vm_name       = "packer-bionic-legacy"
  guest_os_type = "Ubuntu_64"
  iso_interface = "sata"
  disk_size     = "8000"
  vboxmanage    = [
    ["modifyvm", "{{ .Name }}", "--firmware", "BIOS"],
    ["modifyvm", "{{ .Name }}", "--memory", "1024"],
    ["modifyvm", "{{ .Name }}", "--cpus", "1"]
  ]

  # DEPLOYMENT SETTINGS
  http_directory         = "./src/_http/debian-installer/ubuntu-18.04"
  boot_wait              = "5s"
  boot_keygroup_interval = "250ms"
  boot_command           = [
    "<esc><wait5>", # Interrupt automatic boot
    "<esc><wait5>",
    "<f6><wait5>", # Enter console
    "<esc><wait5>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>", # Remove default entry
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><wait>",
    "/install/vmlinuz<spacebar><wait>",
    "initrd=/install/initrd.gz<spacebar><wait>",
    "auto-install/enable=true<spacebar><wait>", # Delays the locale and keyboard questions until after there has been a chance to preseed them
    "debconf/priority=critical<spacebar><wait>", # Stops any questions with a lower priority from being asked
    "debian-installer/framebuffer=false<spacebar><wait>", # Some architectures use the kernel framebuffer to offer installation in a number of languages
    "debconf/frontend=noninteractive<spacebar><wait>", # Type of user interface used for the installer (DEBIAN_FRONTEND)
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<spacebar><wait>", # Location of preseed.cfg
    "---<wait><enter>" # Anything that is passed after the '---' are appended to the default options for the installed system; everything before the '--' is only used by the installer itself.
  ]

  shutdown_command = "echo 'packer' | sudo shutdown -P now"
  shutdown_timeout = "30m"

  # CONNECTION SETTINGS
  communicator = "ssh"
  ssh_pty      = true
  ssh_port     = 22
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_timeout  = "30m"
}
