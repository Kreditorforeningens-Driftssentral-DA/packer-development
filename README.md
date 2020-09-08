# PACKER-DEVELOPMENT

This repository contains only public information

* Terraform: Generating dynamic deployment templates
* Packer/Virtualbox: Building Ubuntu 20.04 basic boxes
* Packer/Virtualbox: Building Windows 2019 basic boxes
* Packer/Virtualbox: Building HashiCluster box (consul, vault & nomad)
* Vagrant/Virtualbox: Testing boxes created in this repo

## Required software
* HashiCorp Terraform
* HashiCorp Packer
* HashiCorp Vagrant
* Oracle Virtualbox

# WORKFLOW
1. Customize and generate deployment-templates (./src/terraform/*) using HashiCorp Terraform
2. Create required base .ova-images (./src/packer/base/*) using HashiCorp Packer
3. Create application images (./src/packer/apps/*) using HashiCorp Packer
4. Spin up required applications (./tests/vagrant/*) using HashiCorp Vagrant

## Generate templates with Terraform
```bash
# You can update the Autounattend.xml template with your
# own parameters manually, or by using terraform:

# Initialize terraform
terraform init ./src/terraform/w2k19-templates

# Render file with variables
terraform apply -auto-approve ./src/terraform/w2k19-templates

# Destroy the file(s)
terraform destroy -auto-approve ./src/terraform/w2k19-templates
```

## Create Base-images with packer
Packer should run from repository root folder, as all paths are relative to this. Example:

```bash
## Execute packer build for Windows base image
packer build -force -only="base.virtualbox-iso.w2k19core-bios" ./src/packer/base/windows/w2k19/

## Execute packer build for Ubuntu base image
packer build -force -only="base.virtualbox-iso.focal-bios" ./src/packer/base/ubuntu/focal/

# Exported images will be placed in ./output
```

## Create Application-images with packer
```bash
## Execute packer build for Windows base image
packer build -force ./src/packer/apps/hashicluster/
```

## Testing with Vagrant
```bash
cd ./tests/vagrant
vagrant up
```
