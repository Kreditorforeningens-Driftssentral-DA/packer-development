locals {

  core = {
    template       = "./src/terraform/w2k19-templates/2019-template.xml"
    rendered_file  = "./src/_floppy/w2k19/core/Autounattend.xml"
    image_index    = "1"
    computername   = "w2k19core"
    input_locale   = "nb-NO"
    timezone       = "W. Europe Standard Time"
    admin_password = "packer"
    local_username = "vagrant"
    local_password = "vagrant"
  }
}

# Optionally allow input from variables
#variable "input_locale" {}
#variable "admin_password" {}
#variable "local_username" {}
#variable "local_password" {}
#variable "computername" {}
#variable "timezone" {}