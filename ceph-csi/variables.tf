variable "cluster_id" {
  description = "Ceph Cluster ID"
  type        = string
}

variable "pool" {
  description = "Ceph RBD Pool"
  type        = string
}

variable "monitors" {
  description = "Ceph Monitors"
  type        = list(string)
}

variable "ceph_user_id" {
  description = "Ceph User ID"
  type        = string
  sensitive   = true

}

variable "ceph_user_key" {
  description = "Ceph User Key"
  type        = string
  sensitive   = true
}

# Default Variables
variable "namespace" {
  description = "Namespace used for Helm chart"
  type        = string
  default     = "kube-system"
}

variable "sc_name" {
  description = "Storageclass name"
  type        = string
  default     = "csi-rbd-sc"
}

variable "chart_version" {
  description = "Ceph CSI Chart Version"
  type        = string
  default     = "v3.10.1"
}