resource "kubernetes_secret" "this" {
  metadata {
    name      = "pdns-key"
    namespace = var.secret_namespace
  }

  data = {
    key = var.pdns_key
  }
}