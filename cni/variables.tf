variable "namespace" {
  default = "kube-system"
  type    = string
}

variable "router_ip" {
  type = string
}

variable "asn" {
  type = number
}