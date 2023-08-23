resource "kubernetes_service" "nginx" {
  metadata {
    name      = "proxy-service-example"
    namespace = var.namespace
  }

  spec {
    selector = {
      App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30202
      port        = 80
      target_port = 80
    }
    type = "NodePort"
  }
}