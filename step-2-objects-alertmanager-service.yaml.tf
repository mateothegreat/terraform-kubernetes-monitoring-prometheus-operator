resource "kubernetes_manifest" "alertmanager-service" {

    depends_on = [ kubernetes_manifest.crd-alertmanager ]

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "alertmanager": "main"
        },
        "name": "alertmanager-main",
        "namespace": var.operator_namespace
    },
    "spec": {
        "type": "ClusterIP",
        "clusterIP": "None",
        "ports": [
            {
                "name": "web",
                "port": 9093,
                "targetPort": "web",
                "protocol": "TCP"
            }
        ],
        "selector": {
            "alertmanager": "main",
            "app": "alertmanager"
        },
        "sessionAffinity": "ClientIP"
    }
}

}
