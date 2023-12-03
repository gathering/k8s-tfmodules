variable "name" {
  description = "Name of LoadBalancer"
  type        = string
}

variable "extip" {
  description = "External IPv6 address"
  type        = string
}

variable "realservers" {
  description = "List of controlplane nodes (IPv6)"
  type        = list(string)
}

variable "dstintf" {
  description = "Dst interface for policy"
  default     = "Infra"
}

variable "srcintf" {
  description = "Src interface for policy"
  default     = "Infra"
}