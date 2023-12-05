resource "fortios_routerbgp_neighbor" "this" {
  count = length(var.neighbors)

  ip                           = var.neighbors[count.index].ip
  remote_as                    = var.remote_as
  activate                     = "disable"
  activate6                    = "enable"
  soft_reconfiguration6        = "enable"
  capability_graceful_restart6 = "enable"
  description                  = "Cluster: ${var.cluster_name} Node: ${var.neighbors[count.index].name}"
}