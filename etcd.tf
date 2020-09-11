resource "lxd_container" "etcd" {
  count = 3
  name  = "etcd-${count.index}"
  image = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
