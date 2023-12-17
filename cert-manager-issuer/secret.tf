resource "kubernetes_secret" "this" {
  metadata {
    name      = "pdns-key"
    namespace = var.namespace
  }

  data = {
    key = var.pdns_key
  }
}