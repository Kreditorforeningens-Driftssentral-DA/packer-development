# packer-development

Packer should run from repository root folder, as all paths are relative to this. Example:

```bash
## Execute packer build for Windows
packer build --force ./src/packer-windows/w2k19core/ --only="virtualbox-iso.w2k19core-bios"
```