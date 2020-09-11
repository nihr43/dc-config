resource "kubernetes_service" "sshd-vpn" {
  metadata {
    name = "sshd-vpn"
  }
  spec {
    selector = {
      app = "sshd-vpn"
    }
    port {
      port        = "4499"
      target_port = "22"
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "sshd-vpn" {
  metadata {
    name = "sshd-vpn"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "sshd-vpn"
      }
    }
    template {
      metadata {
        labels = {
          app = "sshd-vpn"
        }
      }
      spec {
        container {
          image = "docker-registry.localnet:5000/sshd:latest"
          name  = "sshd-vpn"
        }
      }
    }
  }
}
