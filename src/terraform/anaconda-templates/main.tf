resource "local_file" "centos8" {
    filename = local.centos8.rendered_file
    content  = templatefile(local.centos8.template,
      {
        timezone       = local.centos8.timezone,
        hostname       = local.centos8.hostname,
        root_password = local.centos8.root_password,
        local_username = local.centos8.local_username,
        local_password = local.centos8.local_password,
      }
    )
}
