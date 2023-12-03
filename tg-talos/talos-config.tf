locals {
  cluster_endpoint = "https://[${var.cluster_ip}]:6443"

  machine = {
    network = {
      nameservers = var.nameservers
    }
    features = {
      kubePrism = {
        enabled = true
        port    = 7445
      }
    }
    time = {
      disabled = false
      servers  = var.time_servers
    }
    certSANs = [
      var.cluster_ip
    ]
    # features = {
    #   stableHostname = false
    # }
  }

  cluster = {
    network = {
      cni = {
        name = "none"
      }
      podSubnets     = var.pod_subnets
      serviceSubnets = var.service_subnets
    }
    proxy = {
      disabled = true
    }
    discovery = {
      enabled = true
      registries = {
        kubernetes = {
          disabled = false
        }
        service = {
          disabled = true
        }
      }
    }
  }
}