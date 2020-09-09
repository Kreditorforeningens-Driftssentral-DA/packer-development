# NOTEBOOK

#### Commands

```bash
# Build ova-file
packer build -only="ova.*" <path>

# Build local vagrant-box
packer build -only="vagrant.*" <path>

# Build vagrant-cloud-box
packer build -only="vagrantcloud.*" <path>
```

#### Links

  * https://ubuntu.com/server/docs/install/autoinstall-quickstart
  * https://ubuntu.com/server/docs/install/autoinstall-reference
  * https://cloudinit.readthedocs.io
  * https://netplan.io
  * https://www.virtualbox.org/manual/ch08.html
  * https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_an_advanced_rhel_installation/kickstart-and-advanced-boot-options_installing-rhel-as-an-experienced-user


#### Packer Examples

  * https://github.com/aerialls/madalynn-packer
  * https://imagineer.in/blog/packer-build-for-ubuntu-20-04/
  * https://www.aerialls.io/posts/ubuntu-server-2004-image-packer-subiquity-for-proxmox/
  * https://medium.com/@tlhakhan/ubuntu-server-20-04-autoinstall-2e5f772b655a


#### Generate encrypted/hashed passwords

```bash
# Using openssl
printf 'packer' | openssl passwd -6 -salt packer -stdin

# Using mkpasswd
printf 'packer' | mkpasswd --method=SHA-512 --rounds=4096 --stdin
```


#### ISOs

  * https://centos.uib.no/8/isos/x86_64/CentOS-8.2.2004-x86_64-boot.iso
  * https://centos.uib.no/8/isos/x86_64/CentOS-8.2.2004-x86_64-minimal.iso
  * https://centos.uib.no/8/isos/x86_64/CentOS-8.2.2004-x86_64-dvd1.iso
  * https://centos.uib.no/8/isos/x86_64/CHECKSUM