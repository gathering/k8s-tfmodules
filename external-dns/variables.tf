variable "pdns_server" {
  description = "value"
  type        = string
}

variable "pdns_key" {
  description = "value"
  type = string
  sensitive = true
}

variable "cluster_name" {
  description = "value"
  type        = string
}

variable "domain_filters" {
  description = "value"
  type        = list(string)
}

# Default variables
variable "namespace" {
  description = "value"
  type        = string
  default     = "external-dns"
}

variable "create_namespace" {
  description = "value"
  type        = bool
  default     = true
}

variable "chart_version" {
  description = "value"
  type        = string
  default     = "1.14.5"
}