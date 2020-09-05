# ===================================================================
#  UBUNTU FOCAL (20.04) -- Subiquity & BIOS
# ===================================================================

source "virtualbox-iso" "focal-bios" {
  headless         = true
  keep_registered  = false
  skip_export      = false
  output_directory = var.output_folder

  # SOURCE
  iso_interface   = "sata"
  iso_target_path = var.iso_dl_folder
  iso_checksum    = var.iso_chksum
  iso_urls        = var.iso_urls

  # COMPUTER SETTINGS
  vm_name              = local.virtualbox.vm_name
  guest_os_type        = local.virtualbox.os_type
  disk_size            = local.virtualbox.disk_size
  hard_drive_interface = "sata"
  vboxmanage           = [
    ["modifyvm", "{{ .Name }}", "--firmware", "BIOS"],
    ["modifyvm", "{{.Name}}",   "--vram",     "48"],
    ["modifyvm", "{{ .Name }}", "--cpus",     local.virtualbox.cpus],
    ["modifyvm", "{{ .Name }}", "--memory",   local.virtualbox.memory],
  ]

  # DEPLOYMENT SETTINGS
  http_directory         = "./src/_http/subiquity/ubuntu-focal"
  boot_wait              = "5s"
  boot_keygroup_interval = "500ms"
  boot_command           = [
    "<wait><enter>", # Stop autoboot
    "<wait5><enter>", # Select language
    "<f6><wait3><esc><wait3>", # Open default boot-command for appending info
    "autoinstall <wait>ds=nocloud-net;<wait>s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/<spacebar><wait>", # Trailing slash is important
    "<enter>" # Execute command
  ]

  shutdown_command = "echo 'packer' | sudo shutdown -P now"
  shutdown_timeout = "30m"

  # PROVISIONING SETTINGS
  communicator           = "ssh"
  ssh_username           = local.virtualbox.admin_user
  ssh_password           = local.virtualbox.admin_pass
  ssh_pty                = true
  ssh_handshake_attempts = 30
  ssh_timeout            = "10m"
}

# ===================================================================
#  NOMAD CLUSTER
# ===================================================================