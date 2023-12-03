resource "fortios_routerbgp_neighbor" "this" {
  for_each = toset(var.neighbors)

  ip        = each.key
  remote_as = var.remote_as
  activate  = "disable"
  activate6 = "enable"
}