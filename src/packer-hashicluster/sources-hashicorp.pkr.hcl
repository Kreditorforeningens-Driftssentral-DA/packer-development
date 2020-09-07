source "virtualbox-ovf" "focal-hashicorp" {
  skip_export      = true
  keep_registered  = true
  headless         = true
  source_path      = "${var.output_folder}/packer-ubuntu.ovf"
  output_directory = "${var.output_folder}/hashicorp"
  ssh_username     = local.virtualbox.admin_user
  ssh_password     = local.virtualbox.admin_pass
  shutdown_command = "echo '${local.virtualbox.admin_pass}' | sudo -S shutdown -P now"
}
