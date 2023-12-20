# Default Variables
variable "namespace" {
  description = "value"
  type        = string
  default     = "cert-manager"
}

variable "create_namespace" {
  description = "value"
  default     = true
  type        = bool
}

variable "group_name" {
  description = "Group Name used in cert-manager PDNS"
  default     = "acme.gathering.systems"
  type        = string
}

variable "cert_manager_chart_version" {
  description = "cert-manager chart version"
  type        = string
  default     = "v1.13.3"
}