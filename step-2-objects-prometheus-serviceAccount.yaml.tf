resource "kubernetes_manifest" "prometheus-serviceAccount" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "name": "prometheus-k8s",
        "namespace": var.operator_namespace
    }
}

}
