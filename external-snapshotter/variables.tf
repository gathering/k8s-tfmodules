locals {
  SNAPSHOTTER_URL = "https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${var.snapshot_version}"

  # controller
  SNAPSHOT_RBAC       = "/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml"
  SNAPSHOT_CONTROLLER = "/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml"

  # snapshot CRD
  SNAPSHOTCLASS           = "/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml"
  VOLUME_SNAPSHOT_CONTENT = "/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml"
  VOLUME_SNAPSHOT         = "/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml"
}

variable "snapshot_version" {
  default = "v5.0.1"
}