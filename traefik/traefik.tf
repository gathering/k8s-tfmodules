locals {
  traefik = {
    deployment = {
      replicas = var.replicas
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
      "--entryPoints.websecure.proxyProtocol.trustedIPs=${join(",", var.trusted_ips)}",
      "--providers.kubernetesingress.ingressendpoint.hostname=${var.hostname}"
    ]
  }
}

resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = var.namespace
  create_namespace = var.create_namespace
  repository = "https://traefik.github.io/charts"

  chart   = "traefik"
  version = var.traefik_version

  values = [
    yamlencode(local.traefik)
  ]
}