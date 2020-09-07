source "virtualbox-ovf" "focal-hashicluster" {
  #skip_export      = true
  #keep_registered  = true
  #headless         = true
  #source_path      = "${var.output_folder}/packer-ubuntu.ovf"
  #output_directory = "${var.output_folder}/hashicorp"
  #ssh_username     = local.virtualbox.admin_user
  #ssh_password     = local.virtualbox.admin_pass
  #shutdown_command = "echo '${local.virtualbox.admin_pass}' | sudo -S shutdown -P now"
  keep_registered  = false
  skip_export      = false
  source_path      = "./output/ubuntu/packer-ubuntu.ova"
  vm_name          = "hashicluster"
  vboxmanage       = [
   ["modifyvm", "{{.Name}}", "--memory", "1024"],
   ["modifyvm", "{{.Name}}", "--cpus", "2"],
  ]
  ssh_username     = "packer"
  ssh_password     = "packer"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  output_directory = "./output/hashicluster"
  format           = "ova"
}
