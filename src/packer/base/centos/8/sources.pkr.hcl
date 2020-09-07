# =================================================================
#   CentOS-8 > BIOS installation
# =================================================================

source "virtualbox-iso" "centos-8-bios" {
  headless    = false
  skip_export = true

  # SOURCE
  iso_target_path = "./src/_images/centos"
  iso_checksum    = "file:https://centos.uib.no/8/isos/x86_64/CHECKSUM"
  iso_urls        = [
    "./src/_images/centos/CentOS-8.2.2004-x86_64-boot.iso", # Manually downloaded
    "./src/_images/centos/8d71e8377b300414b6e2ac9d20cf8724f37070f7.iso", # Previously downloaded
    "https://centos.uib.no/8/isos/x86_64/CentOS-8.2.2004-x86_64-boot.iso", # Download
  ]

  # COMPUTER SETTINGS
  vm_name       = "packer-centos-8"
  guest_os_type = "RedHat_64"
  disk_size     = "8192"
  #iso_interface = "sata"
  vboxmanage    = [
    ["modifyvm", "{{ .Name }}", "--firmware", "BIOS"],
    ["modifyvm", "{{ .Name }}", "--cpus", "1"],
    ["modifyvm", "{{ .Name }}", "--memory", "1024"]
  ]

  # DEPLOYMENT SETTINGS
  http_directory         = "./src/_http/anaconda/centos-8"
  boot_wait              = "5s"
  boot_keygroup_interval = "500ms"
  boot_command           = [
    "<esc><wait><esc><wait>", # Enter boot-shell
    "linux<spacebar>vmlinuz<spacebar><wait>", # Specify kernel
    "append<spacebar><wait>",
    "initrd=initrd.img<spacebar><wait>",
    "inst.stage2=hd:LABEL=CentOS-8-2-2004-x86_64-dvd<spacebar><wait>", # Location of the installation program runtime image
    "inst.ks=http://<wait>{{.HTTPIP}}:{{.HTTPPort}}<wait>/ks.cfg<wait><enter>", # Target packer http-server
    "boot<wait><enter>", # Initiate boot
  ]

  shutdown_command = "echo 'packer' | sudo -S /sbin/halt -h -p"
  shutdown_timeout = "30m"

  # PROVISIONING CONNECTION
  communicator           = "ssh"
  ssh_username           = "packer"
  ssh_password           = "packer"
  ssh_pty                = true
  ssh_handshake_attempts = 30
  ssh_timeout            = "30m"
}

# =================================================================
#   CentOS-8 > EFI installation
# =================================================================

source "virtualbox-iso" "centos-8-bios" {
  headless    = false
  skip_export = true

  # SOURCE
  iso_target_path = "./src/_images/centos"
  iso_checksum    = "file:https://centos.uib.no/8/isos/x86_64/CHECKSUM"
  iso_urls        = [
    "./src/_images/centos/CentOS-8.2.2004-x86_64-boot.iso", # Manually downloaded
    "./src/_images/centos/8d71e8377b300414b6e2ac9d20cf8724f37070f7.iso", # Previously downloaded
    "https://centos.uib.no/8/isos/x86_64/CentOS-8.2.2004-x86_64-boot.iso", # Download
  ]

  # COMPUTER SETTINGS
  vm_name       = "packer-centos-8"
  guest_os_type = "RedHat_64"
  disk_size     = "8192"
  #iso_interface = "sata"
  vboxmanage    = [
    ["modifyvm", "{{ .Name }}", "--firmware", "BIOS"],
    ["modifyvm", "{{ .Name }}", "--cpus", "1"],
    ["modifyvm", "{{ .Name }}", "--memory", "1024"]
  ]

  # DEPLOYMENT SETTINGS
  http_directory         = "./src/_http/anaconda/centos-8"
  boot_wait              = "1s"
  boot_keygroup_interval = "500ms"
  boot_command           = [
    "<esc><wait><esc><wait>", # Enter boot-shell
    "linuxefi<spacebar>/images/pxeboot/vmlinuz<spacebar><wait>", # Specify kernel
    "append<spacebar><wait>",
    "initrdefi=/images/pxeboot/initrd.img<spacebar><wait>",
    "inst.stage2=hd:LABEL=CentOS-8-2-2004-x86_64-dvd<spacebar><wait>", # Location of the installation program runtime image
    "inst.ks=http://<wait>{{.HTTPIP}}:{{.HTTPPort}}<wait>/ks.cfg<wait><enter>", # Target packer http-server
    "boot<enter>", # Initiate boot
  ]

  shutdown_command = "echo 'packer' | sudo -S /sbin/halt -h -p"
  shutdown_timeout = "30m"

  # PROVISIONING CONNECTION
  communicator           = "ssh"
  ssh_username           = "packer"
  ssh_password           = "packer"
  ssh_pty                = true
  ssh_handshake_attempts = 30
  ssh_timeout            = "30m"
}

