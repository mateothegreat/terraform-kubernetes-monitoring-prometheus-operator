resource "kubernetes_manifest" "alertmanager-serviceMonitor" {

    depends_on = [

        kubernetes_manifest.crd-servicemonitors,
        kubernetes_manifest.crd-alertmanager

    ]

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
