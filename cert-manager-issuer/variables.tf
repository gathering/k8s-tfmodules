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
  type        = list(string)
}

# Default Variables
variable "secret_namespace" {
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