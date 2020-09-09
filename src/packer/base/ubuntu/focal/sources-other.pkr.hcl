# Dummy source for building from existing sources
# https://www.packer.io/docs/post-processors/vagrant#using-together-with-the-artifice-post-processor
source "null" "dummy" {
  communicator = "none"
}
