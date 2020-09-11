resource "lxd_container" "minio-yellow" {
  count  = 4
  name   = "minio-yellow-${count.index}"
  image  = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
