resource "fortios_firewall_vip6" "k8s_api" {
  name        = "${var.name}-k8s-api"
  extip       = var.extip
  extport     = "6443"
  server_type = "tcp"
  ldb_method  = "static"
  mappedip    = "::"
  type        = "server-load-balance"

  monitor {
    name = "tcp-check" # Hardcoded
  }

  dynamic "realservers" {
    for_each = var.realservers
    content {
      ip   = realservers.value
      port = 6443
    }
  }
}

resource "fortios_firewall_vip6" "talos_control_api" {
  name        = "${var.name}-talos-control-api"
  extip       = var.extip
  extport     = "50001"
  server_type = "tcp"
  ldb_method  = "static"
  mappedip    = "::"
  type        = "server-load-balance"

  monitor {
    name = "tcp-check" # Hardcoded
  }

  dynamic "realservers" {
    for_each = var.realservers
    content {
      ip   = realservers.value
      port = 50001
    }
  }
}

resource "fortios_firewall_vip6" "talosctl_api" {
  name        = "${var.name}-talosctl-api"
  extip       = var.extip
  extport     = "50000"
  server_type = "tcp"
  ldb_method  = "static"
  mappedip    = "::"
  type        = "server-load-balance"

  monitor {
    name = "tcp-check" # Hardcoded
  }

  dynamic "realservers" {
    for_each = var.realservers
    content {
      ip   = realservers.value
      port = 50000
    }
  }
}