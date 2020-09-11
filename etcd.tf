resource "minio_s3_bucket" "etcd" {
  bucket = "etcd"
  acl    = "private"
}

resource "lxd_container" "etcd" {
  depends_on  = [minio_s3_bucket.etcd]
  count = 3
  name  = "etcd-${count.index}"
  image = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
