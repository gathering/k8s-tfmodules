resource "fortios_firewall_policy" "this" {
  action           = "accept"
  inspection_mode  = "proxy"
  internet_service = "disable"
  logtraffic       = "all"
  name             = "k8s-lab-talos-in"
  schedule         = "always"
  ssl_ssh_profile  = "SSL-Monitor"
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
    name = "k8s-lab-talos"
  }

  service {
    name = "ALL"
  }

  depends_on = [
    fortios_firewall_vip6.this
  ]
}