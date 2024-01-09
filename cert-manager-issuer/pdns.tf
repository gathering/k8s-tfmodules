locals {
  cert_manager_pdns = {
    groupName = var.group_name
  }
}

resource "helm_release" "cert_manager_pdns" {
  name       = "cert-manager-pdns"
  namespace  = var.namespace
  repository = "https://zachomedia.github.io/cert-manager-webhook-pdns"

  chart   = "cert-manager-webhook-pdns"
  version = var.cert_manager_pdns_version

  values = [
    yamlencode(local.cert_manager_pdns)
  ]
}