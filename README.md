# packer-development

# WORKFLOW

#### Required software
* HashiCorp Terraform
* HashiCorp Packer
* HashiCorp Vagrant
* Oracle Virtualbox

#### Steps
1. Customize and generate deployment-templates (./src/terraform/*) using terraform
2. Create required base .ova-images (./src/packer-base/*) using packer
3. Create application images (./src/packer-apps/*) using packer
4. Spin up required applications (./tests/vagrant/*) using vagrant


## Generate templates (Windows)

```bash
# You can update the Autounattend.xml template with your
# own parameters manually, or by using terraform:

# Initialize terraform
terraform init ./src/terraform/w2k19-templates

# Render file with variables
terraform apply -auto-approve ./src/terraform/w2k19-templates

# Destroy the file
terraform destroy -auto-approve ./src/terraform/w2k19-templates
```

## Creating base-images

Packer should run from repository root folder, as all paths are relative to this. Example:

```bash
## Execute packer build for Windows base image
packer build -force -only="base.virtualbox-iso.w2k19core-bios" ./src/packer-windows/w2k19core/

## Execute packer build for Ubuntu base image
packer build -force -only="base.virtualbox-iso.focal-bios" ./src/packer-ubuntu/focal/

# Exported images will be placed in ./output
```

## Creating application-images
TODO