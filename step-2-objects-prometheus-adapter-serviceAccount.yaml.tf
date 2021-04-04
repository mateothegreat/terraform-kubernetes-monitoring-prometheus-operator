resource "kubernetes_manifest" "prometheus-adapter-serviceAccount" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "name": "prometheus-adapter",
        "namespace": var.operator_namespace
    }
}

}
