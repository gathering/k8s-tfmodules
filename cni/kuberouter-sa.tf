resource "kubernetes_service_account" "kuberouter" {
  metadata {
    name      = "kube-router-sa"
    namespace = var.namespace
  }
}

resource "kubernetes_cluster_role" "kuberouter" {
  metadata {
    name = "kube-router"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods", "services", "nodes", "endpoints"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["networkpolicies"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["networkpolicies"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["coordination.k8s.io"]
    resources  = ["leases"]
    verbs      = ["get", "create", "update"]
  }

  rule {
    api_groups = ["services/status"]
    resources  = ["leases"]
    verbs      = ["update"]
  }

  rule {
    api_groups = ["discovery.k8s.io"]
    resources  = ["endpointslices"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "kuberouter" {
  metadata {
    name = "kube-router"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.kuberouter.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.kuberouter.metadata[0].name
    namespace = kubernetes_service_account.kuberouter.metadata[0].namespace
  }
}