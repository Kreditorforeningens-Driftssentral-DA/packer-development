# ===================================================================
#  WINDOWS SERVER 2019 CORE
# ===================================================================

source "virtualbox-iso" "w2k19core-bios" {
  headless         = true
  keep_registered  = false
  skip_export      = false
  output_directory = "./output/windows/"

  # SOURCE
  iso_target_path = "./src/_iso/windows"
  iso_interface   = "sata"
  iso_checksum    = "md5:70FEC2CB1D6759108820130C2B5496DA" # MD5 is faster compared to e.g. SHA256 for large files
  iso_urls        = var.iso_urls

  # COMPUTER SETTINGS
  vm_name              = local.virtualbox.vm_name
  guest_os_type        = local.virtualbox.os_type
  disk_size            = local.virtualbox.disk_size
  hard_drive_interface = "sata"
  vboxmanage           = [
    ["modifyvm", "{{.Name}}", "--firmware", "BIOS"],
    ["modifyvm", "{{.Name}}", "--vram",     "48"],
    ["modifyvm", "{{.Name}}", "--cpus",     local.virtualbox.cpus],
    ["modifyvm", "{{.Name}}", "--memory",   local.virtualbox.memory],
  ]

  # DEPLOYMENT SETTINGS
  #  Unless the boot is halted (e.g. 'boot_command'),
  #  it will automatically try to boot using
  #  any attached 'Autounattend.xml' file
  boot_wait              = "-1s"
  shutdown_command       = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout       = "30m"
  guest_additions_mode   = "attach"
  floppy_files           = ["./src/_floppy/w2k19/core/Autounattend.xml"]
  boot_keygroup_interval = "500ms"

  # PROVISIONING CONNECTION
  communicator   = "winrm"
  winrm_username = local.virtualbox.admin_user
  winrm_password = local.virtualbox.admin_pass
  winrm_use_ssl  = true
  winrm_insecure = true
  winrm_timeout  = "1h"
}
