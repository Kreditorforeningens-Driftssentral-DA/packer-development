# _____________________________________
#  _           _ _     _
# | |__  _   _(_) | __| | ___ _ __ ___
# | '_ \| | | | | |/ _` |/ _ \ '__/ __|
# | |_) | |_| | | | (_| |  __/ |  \__ \
# |_.__/ \__,_|_|_|\__,_|\___|_|  |___/
# _____________________________________
build {
  sources = ["source.virtualbox-iso.ubuntu-focal"]

  provisioner "shell" {
    inline = ["ls -lts /"]
  }
}