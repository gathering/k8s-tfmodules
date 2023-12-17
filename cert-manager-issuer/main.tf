resource "kubernetes_manifest" "letsencrypt_staging" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"

    metadata = {
      name = "letsencrypt-staging"
    }

    spec = {
      acme = {
        email  = var.acme_email
        server = "https://acme-staging-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "letsencrypt-staging-account-key"
        }
        solvers = [
          {
            dns01 = {
              webhook = {
                groupName  = var.group_name
                solverName = var.solver_name
                config = {
                  host = var.pdns_server
                  apiKeySecretRef = {
                    name = var.secret_name
                    key  = var.secret_key
                  }
                  ttl           = 120
                  timeout       = 10
                  allowed_zones = var.allowed_zones
        } } } }]
      }
    }
  }
}

resource "kubernetes_manifest" "letsencrypt_prod" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"

    metadata = {
      name = "letsencrypt"
    }

    spec = {
      acme = {
        email  = var.acme_email
        server = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "letsencrypt-staging-account-key"
        }
        solvers = [
          {
            dns01 = {
              webhook = {
                groupName  = var.group_name
                solverName = var.solver_name
                config = {
                  host = var.pdns_server
                  apiKeySecretRef = {
                    name = var.secret_name
                    key  = var.secret_key
                  }
                  ttl           = 120
                  timeout       = 10
                  allowed_zones = var.allowed_zones
        } } } }]
      }
    }
  }
}