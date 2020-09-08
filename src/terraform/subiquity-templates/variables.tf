locals {

  focal = {
    template       = "./src/terraform/subiquity-templates/user-data-template.yaml"
    rendered_file  = "./src/_http/subiquity/ubuntu-focal/user-data"
    input_locale   = "nb-NO"
    timezone       = "Europe/Oslo"
    admin_password = "packer"
    local_username = "packer"
    local_password = "$6$packer$boWUDPn2ItbIVp75vZkcB9enktYcH/yND03ZqeO.xN1ydPY2A8ZRsbTDbbiRlToGQ97O4.AM3Tdw9FQoPk41k."
  }
}
