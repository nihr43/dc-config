resource "minio_s3_bucket" "cockroachdb" {
  bucket = "cockroachdb"
  acl    = "private"
}

resource "lxd_container" "cockroachdb" {
  count  = 3
  name   = "cockroachdb-${count.index}"
  image  = "alpine/stable"
  limits = { cpu = 2 }
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
