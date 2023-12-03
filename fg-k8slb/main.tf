resource "fortios_firewall_vip6" "this" {
  name        = "k8s-lab-talos"
  extip       = "2a02:d140:c012:3::eee"
  extport     = "6443"
  server_type = "tcp"
  ldb_method  = "static"
  mappedip    = "::"
  type        = "server-load-balance"

  monitor {
    name = "kube-tcp-check"
  }

  realservers {
    ip   = "2a02:d140:c012:14::2"
    port = 6443
  }
  realservers {
    ip   = "2a02:d140:c012:14::3"
    port = 6443
  }
  realservers {
    ip   = "2a02:d140:c012:14::4"
    port = 6443
  }
}