source "virtualbox-ovf" "focal-hashicluster" {
  keep_registered  = false
  skip_export      = false
  source_path      = "./builds/base/ubuntu/packer-ubuntu.ova"
  vm_name          = "hashicluster"
  vboxmanage       = [
    ["modifyvm", "{{.Name}}", "--memory", "1024"],
    ["modifyvm", "{{.Name}}", "--cpus", "2"],
  ]
  ssh_username     = "packer"
  ssh_password     = "packer"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  output_directory = "./builds/apps/hashicluster"
  format           = "ova"
}
