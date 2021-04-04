resource "kubernetes_manifest" "prometheus-operator-serviceMonitor" {

    depends_on = [ kubernetes_manifest.crd-servicemonitors ]

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "monitoring.coreos.com/v1",
    "kind": "ServiceMonitor",
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
        "endpoints": [
            {
                "bearerTokenFile": "/var/run/secrets/kubernetes.io/serviceaccount/token",
                "honorLabels": true,
                "port": "https",
                "scheme": "https",
                "tlsConfig": {
                    "insecureSkipVerify": true
                }
            }
        ],
        "selector": {
            "matchLabels": {
                "app.kubernetes.io/component": "controller",
                "app.kubernetes.io/name": "prometheus-operator",
                "app.kubernetes.io/version": "v0.42.1"
            }
        }
    }
}

}
