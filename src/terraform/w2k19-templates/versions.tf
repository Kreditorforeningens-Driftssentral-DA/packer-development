# Terraform requirements
terraform {
  required_version = "~> 0.13"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 1.4"
    }
  }
}
