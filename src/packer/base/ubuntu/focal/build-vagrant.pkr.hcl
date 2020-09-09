# Create local vagrant box(es)
# packer build -only="box.*" ./src/packer/base/ubuntu/focal
build {
  name    = "vagrant"
  sources = ["source.null.dummy"]

  # Run in serial
  post-processors {
    post-processor "artifice" {
      files = ["${local.output_folder}/${local.output_filename}.ova"]
    }

    post-processor "vagrant" {
      keep_input_artifact = true
      provider_override   = "virtualbox"
      output              = "${local.output_folder}/${local.output_filename}_{{.Provider}}.box"
      compression_level   = 9
    }
  }
}