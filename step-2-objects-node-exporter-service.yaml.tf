resource "kubernetes_manifest" "node-exporter-service" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "app.kubernetes.io/name": "node-exporter",
            "app.kubernetes.io/version": "v1.0.1"
        },
        "name": "node-exporter",
        "namespace": var.operator_namespace
    },
    "spec": {
        "clusterIP": "None",
        "ports": [
            {
                "name": "https",
                "port": 9100,
                "targetPort": "https",
                "protocol": "TCP"
            }
        ],
        "selector": {
            "app.kubernetes.io/name": "node-exporter"
        }
    }
}

}
