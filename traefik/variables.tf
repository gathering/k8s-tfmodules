variable "trusted_ips" {
  description = "value"
  type        = list(string)
}

variable "hostname" {
  description = "value"
  type        = string
}

# Default Variables
variable "traefik_version" {
  description = "value"
  type        = string
  default     = "v26.0.0"
}

variable "namespace" {
  description = "value"
  type        = string
  default     = "kube-system"
}

variable "replicas" {
  description = "value"
  type        = number
  default     = 3
}