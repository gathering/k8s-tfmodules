resource "fortios_firewall_vip6" "this" {
  name        = var.name
  extip       = var.extip
  extport     = "6443"
  server_type = "tcp"
  ldb_method  = "static"
  mappedip    = "::"
  type        = "server-load-balance"

  monitor {
    name = "kube-tcp-check" # Hardcoded
  }

  dynamic "realservers" {
    for_each = var.realservers
    content {
      ip   = realservers.value
      port = 6443
    }
  }
}