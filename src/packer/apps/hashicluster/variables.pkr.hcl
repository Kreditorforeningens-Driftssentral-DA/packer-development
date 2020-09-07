locals {
  # Variables passed to virtualbox builder
  virtualbox = {
    #os_type     = "Ubuntu_64" #var.os_definition[virtualbox]
    #admin_user  = var.admin_password
    #admin_pass  = var.admin_password
    #vm_name     = var.vm_name
    #disk_size   = var.disk_size
    #cpus        = var.num_cpu
    #memory      = var.mb_memory
  }
}

# ==========================================================
#  Required variables
# ==========================================================
#  None

# ==========================================================
#  Optional variables
# ==========================================================

#variable "os_definition" {
#  type        = map(string)
#  description = "OS-type, by builder"
#  default = {
#    virtualbox = "Ubuntu_64"
#    vsphere    = "ubuntu64Guest" # https://code.vmware.com/apis/358/vsphere/doc/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html
#  }
#}

variable "vm_name" {
  type        = string
  description = "(Optional) Name of the VM to provision"
  default     = "packer-ubuntu"
}

variable "disk_size" {
  type        = string
  description = "(Optional) VM disksize"
  default     = "8192"
}

variable "num_cpu" {
  type        = string
  description = "(Optional) VM CPU-count"
  default     = "1"
}

variable "mb_memory" {
  type        = string
  description = "(Optional) VM memorysize (MB)"
  default     = "768"
}

variable "admin_username" {
  type        = string
  description = "(Optional) Administrator username"
  default     = "packer"
}

variable "admin_password" {
  type        = string
  description = "(Optional) Administrator password"
  default     = "packer"
}

variable "iso_urls" {
  type        = list(string)
  description = "(Optional) Location of installer iso-files"
  default     = [
    "./src/_iso/ubuntu/ubuntu-20.04.1-live-server-amd64.iso",
    "http://releases.ubuntu.com/focal/ubuntu-20.04.1-live-server-amd64.iso",
  ]
}

variable "iso_chksum" {
  type        = string
  description = "(Optional) Installer iso-file checksum"
  default     = "file:http://releases.ubuntu.com/focal/SHA256SUMS"
}

variable "iso_dl_folder" {
  type        = string
  description = "(Optional) Downloadfolder for iso-file(s)"
  default     = "./src/_iso/ubuntu/"
}

variable "output_folder" {
  type        = string
  description = "(Optional) Location to save outputfiles"
  default     = "./output/ubuntu"
}
