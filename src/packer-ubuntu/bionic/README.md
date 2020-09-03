#### Useful documents

  * https://ubuntu.com/server/docs/install/autoinstall-quickstart
  * https://ubuntu.com/server/docs/install/autoinstall-reference
  * https://cloudinit.readthedocs.io
  * https://netplan.io
  * https://www.virtualbox.org/manual/ch08.html


#### Packer Examples

  * https://github.com/aerialls/madalynn-packer
  * https://imagineer.in/blog/packer-build-for-ubuntu-20-04/
  * https://www.aerialls.io/posts/ubuntu-server-2004-image-packer-subiquity-for-proxmox/
  * https://medium.com/@tlhakhan/ubuntu-server-20-04-autoinstall-2e5f772b655a


#### Generate encrypted/hashed password:

```bash
printf 'packer' | openssl passwd -6 -salt packer -stdin
printf 'packer' | mkpasswd --method=SHA-512 --rounds=4096 --stdin
```

