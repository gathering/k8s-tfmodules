variable "pdns_server" {
  description = "value"
  type        = string
}

variable "secret_name" {
  description = "value"
  type        = string
}

variable "secret_key" {
  description = "value"
  type        = string
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