variable "cluster_id" {
  description = ""
  type        = string
}

variable "pool" {
  description = ""
  type        = string
}

variable "monitors" {
  description = ""
  type        = list(string)
}

variable "ceph_user_id" {
  description = ""
  type        = string
  sensitive   = true

}

variable "ceph_user_key" {
  description = ""
  type        = string
  sensitive   = true
}

# Default Variables
variable "namespace" {
  description = ""
  type        = string
  default     = "kube-system"
}

variable "sc_name" {
  description = ""
  type        = string
  default     = "csi-rbd-sc"
}

variable "chart_version" {
  description = ""
  type        = string
  default     = "v3.10.0"
}