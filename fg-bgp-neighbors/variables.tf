variable "cluster_name" {
  description = "Cluster Name"
  type = string
}

variable "neighbors" {
  description = "List of nodes"
  type = list(object({
    name = string
    ip   = string
  }))
}

variable "remote_as" {
  description = "Remote AS Number"
  type        = number
  default     = 64513
}