provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.main.token
}

resource "kubernetes_secret" "db" {
  metadata {
    name = "db-secret"
  }
  data = {
    DB_HOST = module.db.db_instance_address
    DB_USER = var.db_user
    DB_PASS = var.db_password
  }
}

resource "kubernetes_deployment" "java_app" {
  metadata {
    name = "java-app"
    labels = { app = "java-app" }
  }
  spec {
    replicas = 2
    selector {
      match_labels = { app = "java-app" }
    }
    template {
      metadata {
        labels = { app = "java-app" }
      }
      spec {
        container {
          image = var.app_image
          name  = "java-app"
          port {
            container_port = 8080
          }
          env {
            name = "DB_HOST"
            value_from {
              secret_key_ref {
                name = "db-secret"
                key  = "DB_HOST"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "java_app_svc" {
  metadata {
    name = "java-app-service"
  }
  spec {
    selector = { app = "java-app" }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}
