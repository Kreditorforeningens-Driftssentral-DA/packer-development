source "virtualbox-iso" "ubuntu-focal" {
  iso_target_path = "./src/_images"
  iso_checksum    = "sha256:443511f6bf12402c12503733059269a2e10dec602916c0a75263e5d990f6bb93"
  iso_urls        = [
    "./src/_images/ubuntu-20.04.1-live-server-amd64.iso",
    "http://ubuntu.uib.no/releases/focal/ubuntu-20.04.1-live-server-amd64.iso"
  ]
  # --
  vm_name = "packer-ubuntu-focal"
  guest_os_type   = "Ubuntu_64"
  disk_size       = "10000"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
    ["modifyvm", "{{ .Name }}", "--memory", "768"],
    ["modifyvm", "{{ .Name }}", "--cpus", "2"]
  ]
  # --
  http_directory = "./src/_http/subiquity/ubuntu-20.04"
  boot_wait      = "5s"
  boot_command   = [
    "<enter><enter><f6><esc><wait>",
    " autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter><wait>"
  ]
  # --
  shutdown_command = "sudo shutdown -P now"
  shutdown_timeout = "20m"
  # --
  communicator = "ssh"
  ssh_port     = 22
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_timeout  = "30m"
}
