resource "lxd_container" "alpine-dev" {
  count = 1
  name  = "alpine-dev-${count.index}"
  image = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
