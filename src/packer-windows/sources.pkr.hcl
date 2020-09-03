source "virtualbox-iso" "w2k19core-efi" {
  headless    = false
  skip_export = true

  # SOURCE
  iso_target_path = "./src/_images/windows"
  iso_checksum    = "none"
  iso_urls        = [
    "./src/_images/windows/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso", # Manually downloaded
    "./src/_images/windows/4c1ae8c3428313763fed84129326c344ec72e2c1.iso", # Previously downloaded
    "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
  ]

  # COMPUTER SETTINGS
  vm_name       = "packer-w2k19core"
  guest_os_type = "Windows2019_64" # VBoxManage list ostypes
  disk_size     = "16384"
  iso_interface = "sata"
  vboxmanage    = [
    ["modifyvm", "{{.Name}}", "--firmware", "EFI"],
    ["modifyvm", "{{.Name}}", "--cpus", "2"],
    ["modifyvm", "{{.Name}}", "--memory", "1024"],
    #[
    #  "storageattach", "{{.Name}}",
    #  "--storagectl", "SATA Controller",
    #  "--type", "dvddrive",
    #  "--port", "3",
    #  "--medium", "./src/_floppy/w2k19core/uefi/autounattend.iso"
    #]
  ]

  # DEPLOYMENT SETTINGS
  guest_additions_mode   = "disable"
  boot_wait              = "5s"
  boot_keygroup_interval = "500ms"
  floppy_files           = [
    "./src/floppy/w2k19core/uefi/*" # Autounattend.xml
  ]
  boot_command           = ["<spacebar>"]

  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"

  # PROVISIONING CONNECTION
  communicator   = "winrm"
  winrm_username = "Administrator"
  winrm_password = "packer"
  winrm_use_ssl  = true
  winrm_insecure = true
  winrm_timeout  = "1h"
}
