resource "minio_s3_bucket" "docker_registry" {
  bucket = "docker-registry"
  acl    = "public-read"
}

resource "lxd_container" "docker-registry" {
  depends_on  = [minio_s3_bucket.docker_registry]
  count = 2
  name  = "docker-registry-${count.index}"
  image = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
  config = { "boot.autostart" = true }
  limits = { cpu = 2 }
}
