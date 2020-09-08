locals {

  centos8 = {
    template       = "./src/terraform/anaconda-templates/ks-template.cfg"
    rendered_file  = "./src/_http/anaconda/centos8/ks.cfg"
    timezone       = "Europe/Oslo"
    hostname       = "centos8"
    root_password  = "$6$packer$boWUDPn2ItbIVp75vZkcB9enktYcH/yND03ZqeO.xN1ydPY2A8ZRsbTDbbiRlToGQ97O4.AM3Tdw9FQoPk41k."
    local_username = "packer"
    local_password = "$6$packer$boWUDPn2ItbIVp75vZkcB9enktYcH/yND03ZqeO.xN1ydPY2A8ZRsbTDbbiRlToGQ97O4.AM3Tdw9FQoPk41k."
  }
}
