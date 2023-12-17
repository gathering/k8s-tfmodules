locals {
  external_dns = {
    provider = {
      name = "pdns"
    }

    txtOwnerId = var.cluster_id

    extraArgs = [
      "--pdns-server=${var.pdns_server}"
    ]
    domainFilters = var.domain_filters
    env = [
      { name = "EXTERNAL_DNS_PDNS_API_KEY"
        valueFrom = {
          secretKeyRef = ""
      } }
    ]
  }
}

resource "helm_release" "this" {
  name       = "external-dns"
  namespace  = var.namespace
  repository = "https://helm.cilium.io"

  chart            = "external-dns"
  version          = var.chart_version
  create_namespace = var.create_namespace

  values = [
    yamlencode(local.external_dns)
  ]

}