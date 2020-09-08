# Terraform requirements
terraform {
  required_version = "~> 0.13"

  backend "local" {
    path = "./src/terraform/anaconda-templates/terraform.tfstate"
  }

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 1.4"
    }
  }
}
