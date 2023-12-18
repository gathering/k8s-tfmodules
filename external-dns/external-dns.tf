locals {
  external_dns = {
    provider = "pdns"

    txtOwnerId = var.cluster_name

    extraArgs = [
      "--pdns-server=${var.pdns_server}",
      "--txt-prefix=k8s-"
    ]
    domainFilters = var.domain_filters
    env = [{ name = "EXTERNAL_DNS_PDNS_API_KEY"
      valueFrom = {
        secretKeyRef = {
          name = kubernetes_secret.this.metadata[0].name
          key  = "key"
        }
    } }]
  }
}

resource "helm_release" "this" {
  name       = "external-dns"
  namespace  = var.namespace
  repository = "https://kubernetes-sigs.github.io/external-dns"

  chart   = "external-dns"
  version = var.chart_version

  values = [
    yamlencode(local.external_dns)
  ]
}