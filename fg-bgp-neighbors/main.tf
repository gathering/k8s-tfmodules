resource "fortios_routerbgp_neighbor" "this" {
  count = length(var.neighbors)

  ip        = var.neighbors[count.index]
  remote_as = var.remote_as
  activate  = "disable"
  activate6 = "enable"
}