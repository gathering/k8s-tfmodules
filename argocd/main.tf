locals {
  argocd = {
    redis-ha = {
      enabled = true
    }

    controller = {
      replicas = 1
    }

    server = {
      autoscaling = {
        enabled     = true
        minReplicas = 2
      }
      # Unsure how to use the grpc with trafik in using "Ingress"
      ingressGrpc = {}
      ingress = {
        enabled = true
        annotations = {
          "cert-manager.io/cluster-issuer" = "letsencrypt"
        }
        hosts            = [var.hostname]
        ingressClassName = "traefik"
        tls = [
          {
            hosts      = [var.hostname]
            secretName = "${var.hostname}-cert"
          }
        ]
      }
      extraArgs = ["--insecure"]
    }

    repoServer = {
      autoscaling = {
        enabled     = true
        minReplicas = 2
      }
    }

    applicationSet = {
      replicas = 2
    }
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  repository       = "https://argoproj.github.io/argo-helm"

  chart   = "argo-cd"
  version = var.chart_version

  values = [
    yamlencode(local.argocd)
  ]
}