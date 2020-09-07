terraform {
  required_version = "~> 0.13"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 1.4"
    }
  }
}

# Description:
#   Create autounattend.xml from template
resource "local_file" "autounattend_core" {
    filename = "./src/_floppy/w2k19/core/Autounattend.xml"
    content  = templatefile("./src/_floppy/w2k19/template/Autounattend.xml.tpl",
      {
        image_index    = local.core.image_index,
        input_locale   = local.core.input_locale,
        admin_password = local.core.admin_password,
        local_username = local.core.local_username,
        local_password = local.core.local_password,
        computername   = local.core.computername,
        timezone       = local.core.timezone,
      }
    )
}
