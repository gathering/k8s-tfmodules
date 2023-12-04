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

  controlplane_config_patches = [yamlencode(merge({ machine = local.machine, cluster = local.cluster })), yamlencode({ cluster = { inlineManifests = var.talos_inline_manifests } })]
  worker_config_patches       = [yamlencode(merge({ machine = local.machine, cluster = local.cluster }))]
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = var.talos_client_configuration
  endpoints            = [var.cluster_ip]
}

resource "local_file" "talosclientconfig" {
  count = var.type == "controlplane" ? 1 : 0

  content  = data.talos_client_configuration.this.talos_config
  filename = "${path.root}/talosconfig"
}