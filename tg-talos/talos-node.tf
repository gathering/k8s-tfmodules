data "talos_machine_configuration" "this" {
  cluster_name     = var.cluster_name
  machine_type     = var.type
  cluster_endpoint = var.cluster_endpoint
  machine_secrets  = var.talos_machine_secrets
  docs             = false
  examples         = false
  talos_version    = "v1.5.5"

  config_patches = [
    yamlencode({
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
        # features = {
        #   stableHostname = false
        # }
      }
    }),
  ]
}

resource "proxmox_virtual_environment_file" "this" {
  count = length(data.proxmox_virtual_environment_nodes.available_nodes.names)

  content_type = "snippets"
  datastore_id = "local"
  node_name    = data.proxmox_virtual_environment_nodes.available_nodes.names[count.index]

  source_raw {
    data      = data.talos_machine_configuration.this.machine_configuration
    file_name = "talos-test.yaml"
  }
}

# We only bootstrap the first controlplane
resource "talos_machine_bootstrap" "this" {
  depends_on = [
    proxmox_virtual_environment_vm.this[0]
  ]
  node                 = trimsuffix(netbox_available_ip_address.this[0].ip_address, "/64") # We assume we always use a /64
  client_configuration = var.talos_client_configuration
}