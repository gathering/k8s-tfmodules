locals {
  cert_manager = {
    installCRDs = true
    prometheus = {
      enabled = false
    }
  }

  cert_manager_pdns = {
    groupName = var.group_name
  }
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  repository = "https://charts.jetstack.io"

  chart   = "cert-manager"
  version = var.cert_manager_chart_version

  values = [
    yamlencode(local.cert_manager)
  ]
}