variable "K8S_PASS" {}
variable "LXD_PASS" {}
variable "PSQL_PASS" {}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

#terraform {
#  backend "etcdv3" {
#    endpoints = ["10.0.0.54:2379"]
#    lock      = true
#    prefix    = "terraform-state/"
#  }
#}

terraform {
  backend "s3" {
    endpoint = "http://minio.localnet:9000"
    bucket = "terraform"
    key = "terraform.tfstate"
    region = "us-east-1"
    force_path_style = true
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
  }
}

provider "lxd" {
  generate_client_certificates = true
  accept_remote_certificate    = true

  lxd_remote {
    name     = "lxd.localnet"
    scheme   = "https"
    address  = "lxd.localnet"
    password = var.LXD_PASS
    default  = true
  }
}

provider "minio" {
  minio_server = "minio.localnet:9000"
  minio_region = "us-east-1"
  minio_access_key = var.AWS_ACCESS_KEY
  minio_secret_key = var.AWS_SECRET_KEY
}

provider "kubernetes" {
  load_config_file = "false"
  host                   = "https://10.0.0.209:6443"
  username               = "admin"
  password               = var.K8S_PASS
  cluster_ca_certificate = file("~/.kube/cluster-ca-cert.pem")
}

provider "postgresql" {
  host            = "postgres-0"
  port            = 5432
  database        = "postgres"
  username        = "terraform"
  password        = var.PSQL_PASS
  sslmode         = "disable"
  connect_timeout = 15
}
