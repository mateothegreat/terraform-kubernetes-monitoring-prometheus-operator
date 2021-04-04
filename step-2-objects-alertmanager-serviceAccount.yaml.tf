resource "kubernetes_manifest" "alertmanager-serviceAccount" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "name": "alertmanager-main",
        "namespace": var.operator_namespace
    }
}

}
