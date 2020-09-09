# Build HashiCluster
#   - Consul
#   - Vault
#   - Nomad
source "virtualbox-ovf" "ubuntu" {
  source_path = "${local.build_folder}/${local.source_image}"
  headless    = true
  skip_export = false

  format           = "ova"
  output_directory = "${local.build_folder}/tmp"

  communicator = "ssh"
  ssh_username = local.ssh_username
  ssh_password = local.ssh_password

  shutdown_command     = "echo ${local.ssh_password} | sudo -S shutdown -P now"
  guest_additions_mode = "disable"

  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--memory", "1024"],
    ["modifyvm", "{{.Name}}", "--cpus", "2"],
  ]
}
