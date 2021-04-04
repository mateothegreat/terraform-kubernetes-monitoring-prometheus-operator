resource "kubernetes_manifest" "prometheus-operator_serviceaccount" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "labels": {
            "app.kubernetes.io/component": "controller",
            "app.kubernetes.io/name": "prometheus-operator",
            "app.kubernetes.io/version": "v0.42.1"
        },
        "name": "prometheus-operator",
        "namespace": var.operator_namespace
    }
}

}