resource "kubernetes_manifest" "grafana-serviceAccount" {

    count = var.grafana_enabled ? 1 : 0

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "name": "grafana",
        "namespace": var.operator_namespace
    }
}

}
