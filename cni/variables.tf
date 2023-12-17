variable "router_ip" {
  description = "value"
  type        = string
}

variable "asn" {
  description = "value"
  type        = number
}

# Default Variables
variable "namespace" {
  description = "value"
  type        = string
  default     = "kube-system"
}