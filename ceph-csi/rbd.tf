locals {
  ceph_rbd = {
    csiConfig = [{
      clusterID = var.cluster_id
      monitors  = var.monitors
    }]

    storageClass = {
      create     = true
      name       = var.sc_name
      cluster_id = var.cluster_id
      pool       = var.pool
    }

    provisioner = {
      replicaCount = 2
    }

    readAffinity = {
      enabled = true
    }

    logLevel = 0
  }
}

resource "helm_release" "ceph_rbd" {
  name       = "rbd"
  namespace  = var.namespace
  repository = "https://ceph.github.io/csi-charts"

  chart   = "ceph-csi-rbd"
  version = var.chart_version

  values = [
    yamlencode(local.ceph_rbd)
  ]

}