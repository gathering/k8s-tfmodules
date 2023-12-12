resource "kubernetes_daemonset" "kuberouter" {
  metadata {
    name      = "kube-router"
    namespace = var.namespace
    labels = {
      k8s-app = "kube-router"
      tier    = "node"
    }
  }

  spec {
    selector {
      match_labels = {
        k8s-app = "kube-router"
        tier    = "node"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app = "kube-router"
          tier    = "node"
        }
      }

      spec {
        priority_class_name  = "system-node-critical"
        service_account_name = kubernetes_service_account.kuberouter.metadata[0].name
        host_network         = true

        container {
          image             = "ghcr.io/olemathias/kube-router:amd64-master"
          name              = "kube-router"
          image_pull_policy = "Always"

          env {
            name = "NODE_NAME"
            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }

          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          args = [
            "--run-router=true",
            "--run-firewall=false",
            "--run-service-proxy=false",
            "--bgp-graceful-restart=true",
            "--enable-cni=false",
            "--enable-ibgp=true",
            "--enable-overlay=false",
            "--peer-router-ips=${var.router_ip}",
            "--peer-router-asns=${var.asn}",
            "--cluster-asn=${var.asn}",
            "--advertise-cluster-ip=true",
            "--advertise-external-ip=true",
            "--advertise-loadbalancer-ip=true",
            "--enable-ipv6=true",
            "--enable-ipv4=false"
          ]

          security_context {
            privileged = true
          }

          volume_mount {
            name       = "xtables-lock"
            mount_path = "/run/xtables.lock"
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = 20244
            }

            initial_delay_seconds = 10
            period_seconds        = 3
          }
        }

        toleration {
          effect   = "NoSchedule"
          operator = "Exists"
        }

        toleration {
          effect   = "NoExecute"
          operator = "Exists"
        }

        volume {
          name = "xtables-lock"
          host_path {
            path = "/run/xtables.lock"
            type = "FileOrCreate"
          }
        }
      }
    }
  }
}