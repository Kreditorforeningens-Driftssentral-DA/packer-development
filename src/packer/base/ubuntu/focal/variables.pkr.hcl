locals {

  # Variables shared by builders
  iso_dl_folder   = var.iso_dl_folder
  iso_chksum      = var.iso_chksum
  iso_urls        = var.iso_urls
  output_folder   = var.output_folder
  output_filename = var.output_filename
  
  # Variables used by virtualbox builder
  virtualbox = {
    os_type     = var.os_type_virtualbox
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
#  Optional variables
# ==========================================================

variable "os_type_virtualbox" {
  type        = string
  description = "(Optional) OS-type used by virtualbox"
  default     = "Ubuntu_64"
}

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
  description = "(Optional)  This is the path to the directory where the resulting virtual machine will be created."
  default     = "./builds/packer"
}

variable "output_filename" {
  type        = string
  description = "(Optional) This is the base name of the file (excluding the file extension)"
  default     = "ubuntu_focal"
}

variable "version" {
  type        = string
  description = "(Optional) Version to tag resulting output"
  default     = "development"
}

variable "vagrant_cloud_access_token" {
  type        = string
  description = "(Optional) Vagrant Cloud access token, for uploading boxes"
  default     = ""
}

variable "vagrant_cloud_box_version" {
  type        = string
  description = "(Optional) Vagrant Cloud box-version"
  default     = "0.0.0"
}

