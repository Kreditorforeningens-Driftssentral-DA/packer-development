# packer-development

Packer should run from repository root folder, as all paths are relative to this. Example:

```bash
## Execute packer build for Windows base image
packer build -force -only="base.virtualbox-iso.w2k19core-bios" ./src/packer-windows/w2k19core/

## Execute packer build for Ubuntu base image
packer build -force -only="base.virtualbox-iso.focal-bios" ./src/packer-ubuntu/focal/

# Exported images will be placed in ./output
```

## Generate Autounattend for windows

```bash
# You can update the Autounattend.xml template with your
# own parameters manually, or by using terraform:

# Initialize terraform
terraform init ./src/_floppy/w2k19/template

# Render file with variables
terraform apply -auto-approve ./src/_floppy/w2k19/template

# Destroy the file
terraform destroy -auto-approve ./src/_floppy/w2k19/template
```