data "talos_machine_configuration" "this" {
  cluster_name     = var.cluster_name
  machine_type     = var.type
  cluster_endpoint = local.cluster_endpoint
  machine_secrets  = var.talos_machine_secrets
  docs             = false
  examples         = false
  talos_version    = var.talos_version

  config_patches = var.type == "controlplane" ? local.controlplane_config_patches : local.worker_config_patches
}

resource "proxmox_virtual_environment_file" "this" {
  for_each = toset(data.proxmox_virtual_environment_nodes.available_nodes.names)

  content_type = "snippets"
  datastore_id = "local"
  node_name    = each.value

  source_raw {
    data      = data.talos_machine_configuration.this.machine_configuration
    file_name = "${var.cluster_name}-${var.type}.yaml"
  }
}

# We only bootstrap the first controlplane
resource "talos_machine_bootstrap" "this" {
  count = var.type == "controlplane" ? 1 : 0

  node                 = trimsuffix(netbox_available_ip_address.this[0].ip_address, "/64") # We assume we always use a /64
  client_configuration = var.talos_client_configuration

  depends_on = [
    proxmox_virtual_environment_vm.this[0]
  ]
}

resource "talos_machine_configuration_apply" "this" {
  count = var.nodes

  client_configuration        = var.talos_client_configuration
  machine_configuration_input = data.talos_machine_configuration.this.machine_configuration
  node                        = trimsuffix(netbox_available_ip_address.this[count.index].ip_address, "/64")

  depends_on = [
    talos_machine_bootstrap.this[0]
  ]
}