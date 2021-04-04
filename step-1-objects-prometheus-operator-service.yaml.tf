resource "kubernetes_manifest" "prometheus-operator_service" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "app.kubernetes.io/component": "controller",
            "app.kubernetes.io/name": "prometheus-operator",
            "app.kubernetes.io/version": "v0.42.1"
        },
        "name": "prometheus-operator",
        "namespace": var.operator_namespace
    },
    "spec": {
        "clusterIP": "None",
        "ports": [
            {
                "name": "https",
                "port": 8443,
                "targetPort": "https",
                "protocol": "TCP"
            }
        ],
        "selector": {
            "app.kubernetes.io/component": "controller",
            "app.kubernetes.io/name": "prometheus-operator"
        }
    }
}

}