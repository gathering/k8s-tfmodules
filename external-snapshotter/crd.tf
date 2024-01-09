# SNAPSHOTCLASS
data "http" "snapshotclass" {
  url = "${local.SNAPSHOTTER_URL}/${local.SNAPSHOTCLASS}"
}

resource "kubernetes_manifest" "snapshotclass" {
  manifest = {
    apiVersion = "apiextensions.k8s.io/v1"
    kind       = "CustomResourceDefinition"
    metadata   = yamldecode(data.http.snapshotclass.response_body).metadata
    spec       = yamldecode(data.http.snapshotclass.response_body).spec
  }

  computed_fields = ["metadata"]
}

# VOLUME_SNAPSHOT_CONTENT
data "http" "volume_snapshot_content" {
  url = "${local.SNAPSHOTTER_URL}/${local.VOLUME_SNAPSHOT_CONTENT}"
}

resource "kubernetes_manifest" "volume_snapshot_content" {
  manifest = {
    apiVersion = "apiextensions.k8s.io/v1"
    kind       = "CustomResourceDefinition"
    metadata   = yamldecode(data.http.volume_snapshot_content.response_body).metadata
    spec       = yamldecode(data.http.volume_snapshot_content.response_body).spec
  }

  computed_fields = ["metadata"]
}

# VOLUME_SNAPSHOT
data "http" "volume_snapshot" {
  url = "${local.SNAPSHOTTER_URL}/${local.VOLUME_SNAPSHOT}"
}

resource "kubernetes_manifest" "volume_snapshot" {
  manifest = {
    apiVersion = "apiextensions.k8s.io/v1"
    kind       = "CustomResourceDefinition"
    metadata   = yamldecode(data.http.volume_snapshot.response_body).metadata
    spec       = yamldecode(data.http.volume_snapshot.response_body).spec
  }

  computed_fields = ["metadata"]
}