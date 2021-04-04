resource "kubernetes_manifest" "grafana-serviceMonitor" {

    count = var.grafana_enabled ? 1 : 0

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "monitoring.coreos.com/v1",
    "kind": "ServiceMonitor",
    "metadata": {
        "name": "grafana",
        "namespace": var.operator_namespace
    },
    "spec": {
        "endpoints": [
            {
                "interval": "15s",
                "port": "http"
            }
        ],
        "selector": {
            "matchLabels": {
                "app": "grafana"
            }
        }
    }
}

}
