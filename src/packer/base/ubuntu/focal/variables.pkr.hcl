locals {

  # Variables shared by builders
  iso_dl_folder = var.iso_dl_folder
  iso_chksum    = var.iso_chksum
  iso_urls      = var.iso_urls
  output_folder = var.output_folder
  
  # Variables used by virtualbox builder
  virtualbox = {
    os_type     = "Ubuntu_64" #var.os_definition[virtualbox]
    version     = var.version
    admin_user  = var.admin_password
    admin_pass  = var.admin_password
    vm_name     = var.vm_name
    disk_size   = var.disk_size
    cpus        = var.num_cpu
    memory      = var.mb_memory
  }
}

# ==========================================================
#  Required variables (no defaults)
# ==========================================================
#  None

# ==========================================================
#  Optional variables
# ==========================================================

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
  default     = "./builds/base/ubuntu"
}

variable "version" {
  type        = string
  description = "(Optional) Version to tag resulting output"
  default     = "development"
}
