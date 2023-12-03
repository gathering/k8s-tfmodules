data "netbox_prefix" "k8s_node_ipv6" {
  prefix = var.netbox_node_prefix
}

data "netbox_vlan" "this" {
  name = var.netbox_node_vlan
}

data "netbox_cluster" "this" {
  name = var.netbox_cluster
}

data "netbox_device_role" "this" {
  name = var.netbox_device_role
}