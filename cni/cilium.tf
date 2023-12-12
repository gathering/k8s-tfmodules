locals {
  cilium = {
    ipam = {
      mode = "kubernetes"
    }
    routingMode          = "native"
    kubeProxyReplacement = true

    ipv4 = {
      enabled = false
    }

    ipv6 = {
      enabled = true
    }

    enableIPv4Masquerade = false
    enableIPv6Masquerade = false

    enableIPv6BIGTCP = true
    bandwidthManager = {
      enabled = true
      bbr     = true
    }

    envoy = {
      enabled = true
    }

    securityContext = {
      capabilities = {
        ciliumAgent = [
          "CHOWN",
          "KILL",
          "NET_ADMIN",
          "NET_RAW",
          "IPC_LOCK",
          "SYS_ADMIN",
          "SYS_RESOURCE",
          "DAC_OVERRIDE",
          "FOWNER",
          "SETGID",
          "SETUID"
        ]
        cleanCiliumState = [
          "NET_ADMIN",
          "SYS_ADMIN",
          "SYS_RESOURCE"
        ]
      }
    }

    cgroup = {
      autoMount = {
        enabled = false
      }
      hostRoot = "/sys/fs/cgroup"
    }

    k8sServiceHost = "localhost" # Talos KubePrism
    k8sServicePort = 7445

    ingressController = {
      enabled = false
    }

    hubble = {
      relay = {
        enabled = true
      }
      ui = {
        enabled = true
      }
    }

    bpf = {
      preallocateMaps = true
    }
  }
}

resource "helm_release" "cilium" {
  name       = "cilium"
  namespace  = var.namespace
  repository = "https://helm.cilium.io"

  chart   = "cilium"
  version = "1.14.4"

  values = [
    yamlencode(local.cilium)
  ]

}