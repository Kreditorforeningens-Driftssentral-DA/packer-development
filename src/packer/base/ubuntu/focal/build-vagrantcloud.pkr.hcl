# Upload vagrant box(es) to vagrant-cloud
# packer build -only="cloudbox.*" ./src/packer/base/ubuntu/focal
build {
  name    = "vagrantcloud"
  sources = ["source.null.dummy"]

  # Run in serial
  post-processors {
    post-processor "artifice" {
      files = ["${local.output_folder}/${local.output_filename}_{{.Provider}}.box"]
    }

    post-processor "vagrant-cloud" {
      box_tag      = "kreditorforeningen/ubuntu-focal" # Must already exist on vagrant-cloud
      no_release   = false
      version      = var.vagrant_cloud_box_version
      access_token = var.vagrant_cloud_access_token
    }
  }
}
