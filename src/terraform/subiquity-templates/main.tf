resource "local_file" "focal" {
    filename = local.focal.rendered_file
    content  = templatefile(local.focal.template,
      {
        input_locale   = local.focal.input_locale,
        local_username = local.focal.local_username,
        local_password = local.focal.local_password,
        timezone       = local.focal.timezone,
      }
    )
}
