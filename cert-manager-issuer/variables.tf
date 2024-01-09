variable "pdns_server" {
  description = "value"
  type        = string
}

variable "pdns_key" {
  description = "value"
  type        = string
  sensitive   = true
}

variable "acme_email" {
  description = "value"
  type        = string
}

variable "allowed_zones" {
  description = "value"
  # The type for some reason breaks kubernetes_manifest
  #type        = list(string)
}

# Default Variables
variable "namespace" {
  description = "value"
  type        = string
  default     = "cert-manager"
}

variable "group_name" {
  description = "value"
  type        = string
  default     = "acme.gathering.systems"
}

variable "solver_name" {
  description = "value"
  type        = string
  default     = "pdns"
}

variable "cert_manager_pdns_version" {
  description = "value"
  type        = string
  default     = "3.1.2"
}