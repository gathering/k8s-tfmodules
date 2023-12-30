# SNAPSHOT_RBAC
data "http" "snapshot_rbac" {
  url = "${local.SNAPSHOTTER_URL}/${local.SNAPSHOT_RBAC}"
}

data "kubectl_file_documents" "snapshot_rbac" {
  content = data.http.snapshot_rbac.response_body
}

resource "kubernetes_manifest" "snapshot_rbac" {
  for_each        = data.kubectl_file_documents.snapshot_rbac.manifests
  manifest        = yamldecode(each.value)
  computed_fields = ["metadata"]
}

# SNAPSHOT_CONTROLLER
data "http" "snapshot_controller" {
  url = "${local.SNAPSHOTTER_URL}/${local.SNAPSHOT_CONTROLLER}"
}

data "kubectl_file_documents" "snapshot_controller" {
  content = data.http.snapshot_controller.response_body
}

resource "kubernetes_manifest" "snapshot_controller" {
  for_each        = data.kubectl_file_documents.snapshot_controller.manifests
  manifest        = yamldecode(each.value)
  computed_fields = ["metadata"]
}