source "virtualbox-iso" "ubuntu-bionic" {
  iso_target_path = "./src/_images"
  iso_checksum    = "sha256:3756b3201007a88da35ee0957fbe6666c495fb3d8ef2e851ed2bd1115dc36446"
  iso_urls        = [
    "./src/_images/ubuntu-18.04.5-live-server-amd64.iso",
    "http://ubuntu.uib.no/releases/bionic/ubuntu-18.04.5-live-server-amd64.iso"
  ]
  # --
  vm_name = "packer-ubuntu-bionic"
  guest_os_type   = "Ubuntu_64"
  disk_size       = "10000"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--firmware", "bios"],
    ["modifyvm", "{{ .Name }}", "--memory", "768"],
    ["modifyvm", "{{ .Name }}", "--cpus", "2"]
  ]
  # --
  http_directory = "./src/_http/debian-installer/ubuntu-18.04"
  boot_wait      = "10s"
  boot_command   = [
    "<esc><wait>",
    "<esc><wait>",
    "<enter><wait>",
    "/install/vmlinuz<wait>",
    " initrd=/install/initrd.gz",
    " auto-install/enable=true",
    " debconf/priority=critical",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>",
    " -- <wait>",
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
