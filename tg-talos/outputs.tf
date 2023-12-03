output "nodes" {
  description = "List of all nodes"
  value       = [proxmox_virtual_environment_vm.this[*].name]
}

output "nodes_ip" {
  description = "List of IPv6 address to nodes"
  value       = [netbox_available_ip_address.this[*].ip_address]
}