locals {
  # Variables passed to virtualbox source
  virtualbox = {
    os_type     = "Windows2019_64"
    admin_user  = var.admin_password
    admin_pass  = var.admin_password
    vm_name     = var.vm_name
    disk_size   = var.disk_size
    cpus        = var.num_cpu
    memory      = var.mb_memory
  }
}

# ==========================================================
#  Required variables
# ==========================================================
#  None

# ==========================================================
#  Optional variables
# ==========================================================

variable "vm_name" {
  type        = string
  description = "(Optional) Name of the VM to provision"
  default     = "packer-w2k19"
}

variable "disk_size" {
  type        = string
  description = "(Optional) VM disksize"
  default     = "16384"
}

variable "num_cpu" {
  type        = string
  description = "(Optional) VM CPU-count"
  default     = "1"
}

variable "mb_memory" {
  type        = string
  description = "(Optional) VM memorysize (MB)"
  default     = "1024"
}

variable "admin_username" {
  type        = string
  description = "(Optional) Administrator username"
  default     = "Administrator"
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
    "./src/_iso/windows/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso", # Manually downloaded
    "./src/_iso/windows/4c1ae8c3428313763fed84129326c344ec72e2c1.iso", # Previously downloaded
    "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso" # Download
  ]
}
