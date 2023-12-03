variable "cluster_name" {}

variable "node_prefix" {
  description = "Prefix for node name"
}

variable "type" {
  description = "worker or controlplane"
}

variable "nodes" {
  description = "Number of nodes to be created"
  default     = 3
}

variable "cores" {
  description = "Number of CPU Cores per node"
  default     = 2
}

variable "memory" {
  description = "Memory size per node (MB)"
  default     = 4096
}

variable "disk" {
  description = "Disk size (OS) per node (GB)"
  default     = 24
}

variable "netbox_node_prefix" {
  description = "Netbox IPv6 prefix for nodes"
}

variable "netbox_node_vlan" {
  description = "Netbox VLAN to place nodes"
}

variable "netbox_site_id" {
}

variable "netbox_cluster" {
  default = "pve"
}

variable "netbox_device_role" {
  default = "Server"
}

variable "device_networkcard_name" {
  default = "eth0"
}

variable "talos_machine_secrets" {
  description = "talos secrets"
}

variable "talos_client_configuration" {
  description = "client_configuration"
}

variable "cluster_endpoint" {
}

variable "cpu_type" {
  default = "Skylake-Server-noTSX-IBRS"
}

variable "pod_subnets" {
  description = ""
}

variable "service_subnets" {
  description = ""
}

variable "nameservers" {
  default = ["2606:4700:4700::64"]
}

variable "datastore" {
  default = "ceph1"
}

variable "vm_brige" {
  default = "vmbr0"
}

variable "domain_name" {
  default = "gathering.systems"
}

variable "time_servers" {
  default = ["time.cloudflare.com"]
}