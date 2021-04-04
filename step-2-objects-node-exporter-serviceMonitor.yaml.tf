resource "kubernetes_manifest" "node-exporter-serviceMonitor" {

    depends_on = [

        kubernetes_manifest.crd-servicemonitors

    ]

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "monitoring.coreos.com/v1",
    "kind": "ServiceMonitor",
    "metadata": {
        "labels": {
            "app.kubernetes.io/name": "node-exporter",
            "app.kubernetes.io/version": "v1.0.1"
        },
        "name": "node-exporter",
        "namespace": var.operator_namespace
    },
    "spec": {
        "endpoints": [
            {
                "bearerTokenFile": "/var/run/secrets/kubernetes.io/serviceaccount/token",
                "interval": "15s",
                "port": "https",
                "relabelings": [
                    {
                        "action": "replace",
                        "regex": "(.*)",
                        "replacement": "$1",
                        "sourceLabels": [
                            "__meta_kubernetes_pod_node_name"
                        ],
                        "targetLabel": "instance"
                    }
                ],
                "scheme": "https",
                "tlsConfig": {
                    "insecureSkipVerify": true
                }
            }
        ],
        "jobLabel": "app.kubernetes.io/name",
        "selector": {
            "matchLabels": {
                "app.kubernetes.io/name": "node-exporter"
            }
        }
    }
}

}
