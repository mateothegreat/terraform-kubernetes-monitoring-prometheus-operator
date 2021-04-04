resource "kubernetes_manifest" "prometheus-adapter-service" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "name": "prometheus-adapter"
        },
        "name": "prometheus-adapter",
        "namespace": var.operator_namespace
    },
    "spec": {
        "type": "ClusterIP",
        "clusterIP": "None",
        "ports": [
            {
                "name": "https",
                "port": 443,
                "targetPort": 6443,
                "protocol": "TCP"
            }
        ],
        "selector": {
            "name": "prometheus-adapter"
        }
    }
}

}
