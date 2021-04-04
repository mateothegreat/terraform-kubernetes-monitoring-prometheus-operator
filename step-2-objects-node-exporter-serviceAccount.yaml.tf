resource "kubernetes_manifest" "node-exporter-serviceAccount" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "name": "node-exporter",
        "namespace": var.operator_namespace
    }
}

}
