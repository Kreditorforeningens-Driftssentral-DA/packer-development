# https://github.com/jcpowermac/packer-centos-ansible/blob/master/kickstart/ks.cfg
source "hyperv-iso" "centos" {
  iso_checksum = "sha256:c87a2d81d67bbaeaf646aea5bedd70990078ec252fc52f5a7d65ff609871e255" # https://centos.uib.no/8/isos/x86_64/CHECKSUM
  iso_urls      = [
    "https://centos.uib.no/8/isos/x86_64/CentOS-8.2.2004-x86_64-dvd1.iso",
    "https://centos.uib.no/8/isos/x86_64/CentOS-8.2.2004-x86_64-minimal.iso"
  ]
  #iso_checksum = "sha256:47ab14778c823acae2ee6d365d76a9aed3f95bb8d0add23a06536b58bb5293c0" # https://centos.uib.no/8/isos/x86_64/CHECKSUM

  http_directory = "http"
  boot_wait      = "10s"
  
  # https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options
  #   "<tab><spacebar>append inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<wait>"
  # https://github.com/marcinbojko/hv-packer/blob/master/variables/variables_centos82.json
  #   "boot_command": "c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=CentOS-8-2-2004-x86_64-dvd inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/gen2-centos8/ks.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"
  boot_command = [
    "c<wait>",
    "setparams 'kickstart'<enter>",
    "linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=CentOS-8-2-2004-x86_64-dvd inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>",
    "initrdefi /images/pxeboot/initrd.img<enter>",
    "boot<enter>"
    ]

  communicator = "ssh"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout  = "30m"
  ssh_port     = 22

  shutdown_timeout = "30m"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

  generation            = 2
  memory                = 384
  enable_dynamic_memory = true
  cpus                  = 2
  disk_size             = 12000
  switch_name           = "Default Switch"
}
