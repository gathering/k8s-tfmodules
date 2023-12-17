locals {
  traefik = {
    deployment = {
      replicas = 3
    }
    service = {
      type = "LoadBalancer"
    }
    ports = {
      web = {
        expose = false
      }
      websecure = {
        expose = true
      }
    }
    additionalArguments = [
      "--entryPoints.websecure.proxyProtocol.trustedIPs=2a02:d140:c012:13::8",
      "--providers.kubernetesingress.ingressendpoint.hostname=cloudproxy.gathering.systems"
    ]
  }
}

resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = var.namespace
  repository = "https://traefik.github.io/charts"

  chart   = "traefik"
  version = "v26.0.0"

  values = [
    yamlencode(local.traefik)
  ]

}