resource "random_id" "this" {
  count  = var.nodes
  prefix = var.node_prefix

  byte_length = 2
}

resource "netbox_virtual_machine" "this" {
  count = var.nodes

  cluster_id   = data.netbox_cluster.this.id
  site_id      = var.netbox_site_id
  role_id      = data.netbox_device_role.this.id
  name         = random_id.this[count.index].hex
  disk_size_gb = var.disk
  memory_mb    = var.memory
  vcpus        = var.cores
}

resource "netbox_interface" "this" {
  count = var.nodes

  name               = var.device_networkcard_name
  virtual_machine_id = resource.netbox_virtual_machine.this[count.index].id
}

resource "netbox_available_ip_address" "this" {
  count = var.nodes

  prefix_id    = data.netbox_prefix.k8s_node_ipv6.id
  status       = "active"
  interface_id = netbox_interface.this[count.index].id
  object_type  = "virtualization.vminterface"
}

resource "netbox_primary_ip" "this" {
  count = var.nodes

  ip_address_id      = netbox_available_ip_address.this[count.index].id
  ip_address_version = 6
  virtual_machine_id = netbox_virtual_machine.this[count.index].id
}