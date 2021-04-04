resource "kubernetes_manifest" "prometheus-adapter-serviceMonitor" {

    depends_on = [ kubernetes_manifest.crd-servicemonitors ]

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "monitoring.coreos.com/v1",
    "kind": "ServiceMonitor",
    "metadata": {
        "labels": {
            "name": "prometheus-adapter"
        },
        "name": "prometheus-adapter",
        "namespace": var.operator_namespace
    },
    "spec": {
        "endpoints": [
            {
                "bearerTokenFile": "/var/run/secrets/kubernetes.io/serviceaccount/token",
                "interval": "30s",
                "port": "https",
                "scheme": "https",
                "tlsConfig": {
                    "insecureSkipVerify": true
                }
            }
        ],
        "selector": {
            "matchLabels": {
                "name": "prometheus-adapter"
            }
        }
    }
}

}
