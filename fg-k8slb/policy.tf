resource "fortios_firewall_policy" "this" {
  action           = "accept"
  inspection_mode  = "proxy"
  internet_service = "disable"
  logtraffic       = "all"
  name             = "${var.name}-in"
  schedule         = "always"
  ssl_ssh_profile  = "SSL-Monitor" # Hardcoded
  status           = "enable"

  dstintf {
    name = "Infra"
  }

  srcaddr6 {
    name = "all"
  }

  srcintf {
    name = "Infra"
  }

  dstaddr6 {
    name = fortios_firewall_vip6.k8s_api.name
  }

  dstaddr6 {
    name = fortios_firewall_vip6.talos_control_api.name
  }

  service {
    name = "ALL"
  }
}