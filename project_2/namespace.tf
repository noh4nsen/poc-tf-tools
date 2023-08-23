resource "kubernetes_namespace" "proxy" {
  metadata {
    annotations = {
      name = var.namespace
    }

    labels = {
      proxy = "true"
    }

    name = var.namespace
  }
}