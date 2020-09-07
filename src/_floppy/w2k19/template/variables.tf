locals {

  core = {
    image_index    = "1"
    input_locale   = "nb-NO"
    admin_password = "packer"
    local_username = "vagrant"
    local_password = "vagrant"
    computername   = "w2k19core"
    timezone       = "W. Europe Standard Time"
  }
}

# Optionally allow input from variables
#variable "input_locale" {}
#variable "admin_password" {}
#variable "local_username" {}
#variable "local_password" {}
#variable "computername" {}
#variable "timezone" {}