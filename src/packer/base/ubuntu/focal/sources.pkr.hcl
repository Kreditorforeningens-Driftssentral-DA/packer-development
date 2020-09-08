# ===================================================================
#  UBUNTU FOCAL (20.04) -- Subiquity w/BIOS (EFI requires iso)
# ===================================================================

source "virtualbox-iso" "focal-bios" {
  headless         = true
  keep_registered  = false
  skip_export      = false
  output_directory = local.output_folder

  # EXPORT OPTIONS
  format      = "ova"
  export_opts = [
    "--manifest",
    "--vsys", "0",
    "--description", "Ubuntu 20.04 base-image",
    "--version", local.virtualbox.version,
  ]

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

  # SOURCE SETTINGS
  iso_interface   = "sata"
  iso_target_path = var.iso_dl_folder
  iso_checksum    = var.iso_chksum
  iso_urls        = var.iso_urls

  # GUEST ADDITIONS
  #guest_additions_interface = "sata"
  #guest_additions_path      = "VBoxGuestAdditions_{{.Version}}.iso"

  # PROVISIONING SETTINGS
  communicator           = "ssh"
  ssh_timeout            = "10m"
  ssh_pty                = true
  ssh_username           = local.virtualbox.admin_user
  ssh_password           = local.virtualbox.admin_pass
  ssh_handshake_attempts = 30

  # DEPLOYMENT SETTINGS
  http_directory         = "./src/_http/subiquity/ubuntu-focal"
  shutdown_command = "echo '${local.virtualbox.admin_pass}' | sudo shutdown -P now"
  shutdown_timeout = "30m"
  boot_wait              = "5s"
  boot_keygroup_interval = "500ms"
  boot_command           = [
    "<wait><enter>", # Stop autoboot
    "<wait5><enter>", # Select language
    "<f6><wait3><esc><wait3>", # Open default boot-command for appending info
    "autoinstall <wait>ds=nocloud-net;<wait>s=http://{{.HTTPIP}}:{{.HTTPPort}}/<spacebar><wait>", # Trailing slash is important
    "<enter>" # Execute command
  ]
}