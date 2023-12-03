variable "neighbors" {
  description = "list of IPv6 nodes"
  type        = list(string)
}

variable "remote_as" {
  description = "Remote AS Number"
  type        = number
  default     = 64513
}