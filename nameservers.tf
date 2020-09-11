resource "lxd_container" "ns" {
  count  = 3
  name   = "ns-${count.index}"
  image  = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
  config = { "boot.autostart" = true }
  limits = { cpu = 2 }
}
