resource "kubernetes_manifest" "kube-state-metrics-service" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "app.kubernetes.io/name": "kube-state-metrics",
            "app.kubernetes.io/version": "1.9.7"
        },
        "name": "kube-state-metrics",
        "namespace": var.operator_namespace
    },
    "spec": {
        "clusterIP": "None",
        "ports": [
            {
                "name": "https-main",
                "port": 8443,
                "targetPort": "https-main",
                "protocol": "TCP"
            },
            {
                "name": "https-self",
                "port": 9443,
                "targetPort": "https-self",
                "protocol": "TCP"
            }
        ],
        "selector": {
            "app.kubernetes.io/name": "kube-state-metrics"
        }
    }
}

}
