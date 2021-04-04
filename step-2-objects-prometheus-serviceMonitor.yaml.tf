resource "kubernetes_manifest" "prometheus-serviceMonitor" {

    depends_on = [ kubernetes_manifest.crd-servicemonitors ]

    provider = kubernetes-alpha

    manifest = {
        "apiVersion": "monitoring.coreos.com/v1",
        "kind": "ServiceMonitor",
        "metadata": {
            "labels": {
                "k8s-app": "prometheus"
            },
            "name": "prometheus",
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
                    "prometheus": "k8s"
                }
            }
        }
    }

}
