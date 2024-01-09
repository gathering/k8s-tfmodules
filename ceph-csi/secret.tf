resource "kubernetes_secret" "this" {
  metadata {
    name      = "ceph-rbd-csi"
    namespace = var.namespace
  }

  data = {
    userID  = var.ceph_user_id
    userKey = var.ceph_user_key
  }
}