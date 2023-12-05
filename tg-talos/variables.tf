variable "cluster_name" {
  description = "Cluster Name"
  type = string
}

variable "node_prefix" {
  description = "Prefix for node name"
  type = string
}

variable "type" {
  description = "worker or controlplane"
  type = string
}

variable "nodes" {
  description = "Number of nodes to be created"
  type = number
  default     = 3
}

variable "cores" {
  description = "Number of CPU Cores per node"
  type = number
  default     = 2
}

variable "memory" {
  description = "Memory size per node (MB)"
  type = number
  default     = 4096
}

variable "disk" {
  description = "Disk size (OS) per node (GB)"
  type = number
  default     = 24
}

variable "netbox_node_prefix" {
  description = "Netbox IPv6 prefix for nodes"
  type = string
}

variable "netbox_node_vlan" {
  description = "Netbox VLAN to place nodes"
  type = string
}

variable "netbox_site_id" {
  description = "Netbox Site ID"
  type = number
}

variable "netbox_cluster" {
  description = "Netbox Cluster Name"
  type = string
  default = "pve"
}

variable "netbox_device_role" {
  description = "Netbox Device Role"
  type = string
  default = "Server"
}

variable "device_networkcard_name" {
  description = "Netbox nic name"
  type = string
  default = "eth0"
}

variable "talos_machine_secrets" {
  description = "talos secrets"
}

variable "talos_client_configuration" {
  description = "client_configuration"
}

variable "cluster_ip" {
  description = "IPv6 LB IP to cluster"
  type = string
}

variable "cpu_type" {
  description = "Proxmox CPU Type"
  type = string
  default = "Skylake-Server-noTSX-IBRS"
}

variable "pod_subnets" {
  description = "k8s pod subnets"
  default     = []
}

variable "service_subnets" {
  description = "k8s service subnets"
  default     = []
}

variable "nameservers" {
  description = "DNS Servers. Use DNS64 if this is a IPv6 only cluster"
  type = list(string)
  default     = ["2606:4700:4700::64"]
}

variable "datastore" {
  description = "Proxmox Datastore"
  type = string
  default = "ceph1"
}

variable "vm_brige" {
  description = "Proxmox Network Bridge"
  type = string
  default = "vmbr0"
}

variable "domain_name" {
  description = "DNS Domain Name"
  type = string
  default = "gathering.systems"
}

variable "time_servers" {
  description = "List of time_servers"
  type = list(string)
  default = ["time.cloudflare.com"]
}

variable "talos_version" {
  description = "Talosctl Version"
  type = string
  default = "v1.5.5"
}

variable "talos_inline_manifests" {
  description = "Talos Inline Manifests"
  #type    = list(object())
  default = []
}