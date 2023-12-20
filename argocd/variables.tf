variable "hostname" {
  description = "Ingress hostname"
  type        = string
}

# Default Variables
variable "chart_version" {
  description = "Helm Chart version"
  type        = string
  default     = "5.51.6"
}

variable "namespace" {
  description = "Namespace used in helm chart"
  type        = string
  default     = "argocd"
}

variable "create_namespace" {
  description = "Create namespace"
  type        = bool
  default     = true
}