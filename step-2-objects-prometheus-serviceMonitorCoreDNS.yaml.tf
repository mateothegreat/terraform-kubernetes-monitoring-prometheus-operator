resource "kubernetes_manifest" "prometheus-serviceMonitorCoreDNS" {

    depends_on = [ kubernetes_manifest.crd-servicemonitors ]

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "monitoring.coreos.com/v1",
    "kind": "ServiceMonitor",
    "metadata": {
        "labels": {
            "k8s-app": "coredns"
        },
        "name": "coredns",
        "namespace": var.operator_namespace
    },
    "spec": {
        "endpoints": [
            {
                "bearerTokenFile": "/var/run/secrets/kubernetes.io/serviceaccount/token",
                "interval": "15s",
                "port": "metrics"
            }
        ],
        "jobLabel": "k8s-app",
        "namespaceSelector": {
            "matchNames": [
                "kube-system"
            ]
        },
        "selector": {
            "matchLabels": {
                "k8s-app": "kube-dns"
            }
        }
    }
}

}
