data "talos_cluster_kubeconfig" "this" {
  count = var.type == "controlplane" ? 1 : 0

  client_configuration = var.talos_client_configuration
  # For unknown reason this is super unstable when using the VIP (I guess that is technically not a node)
  # So using one of the node IPs directly
  node = trimsuffix(netbox_available_ip_address.this[0].ip_address, "/64")

  depends_on = [
    talos_machine_bootstrap.this
  ]
}

resource "local_file" "kubeconfig" {
  count = var.type == "controlplane" ? 1 : 0

  content  = data.talos_cluster_kubeconfig.this[0].kubeconfig_raw
  filename = "${path.root}/kubeconfig"

  lifecycle {
    ignore_changes = [
      content
    ]
  }
}