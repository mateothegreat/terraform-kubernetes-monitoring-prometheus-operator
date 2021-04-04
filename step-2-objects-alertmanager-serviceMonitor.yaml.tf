resource "kubernetes_manifest" "alertmanager-serviceMonitor" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "monitoring.coreos.com/v1",
    "kind": "ServiceMonitor",
    "metadata": {
        "labels": {
            "k8s-app": "alertmanager"
        },
        "name": "alertmanager",
        "namespace": var.operator_namespace
    },
    "spec": {
        "endpoints": [
            {
                "interval": "30s",
                "port": "web"
            }
        ],
        "selector": {
            "matchLabels": {
                "alertmanager": "main"
            }
        }
    }
}

}
