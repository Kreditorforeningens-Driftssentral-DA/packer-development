# Description:
#   Create Autounattend.xml from template
# -- "./src/_floppy/w2k19/core/Autounattend.xml"
resource "local_file" "autounattend_core" {
    filename = local.core.rendered_file
    content  = templatefile(local.core.template,
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
