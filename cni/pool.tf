resource "kubernetes_manifest" "public_pool" {
  manifest = {
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumLoadBalancerIPPool"
    metadata = {
      name = "default-pool"
    }
    spec = {
      cidrs = [
        { cidr = "2a02:d140:c012:20::40:0/112" }
      ]
    }
  }

  depends_on = [helm_release.cilium]
}