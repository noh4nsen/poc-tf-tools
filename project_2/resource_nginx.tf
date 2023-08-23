resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "proxy-example"
    namespace = var.namespace
    labels = {
      App = "proxy-example"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        App = "proxy-example"
      }
    }

    template {
      metadata {
        labels = {
          App = "proxy-example"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "proxy-example"

          resources {
            limits = {
              cpu    = "40m"
              memory = "100Mi"
            }

            requests = {
              cpu    = "20m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}