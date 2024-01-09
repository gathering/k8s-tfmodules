resource "kubernetes_secret" "this" {
  metadata {
    name      = "pdns-key"
    namespace = var.namespace
  }

  data = {
    key = var.pdns_key
  }

  depends_on = [kubernetes_namespace.this]
}