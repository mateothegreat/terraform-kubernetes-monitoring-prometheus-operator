resource "kubernetes_manifest" "alertmanager-alertmanager" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "monitoring.coreos.com/v1",
    "kind": "Alertmanager",
    "metadata": {
        "labels": {
            "alertmanager": "main"
        },
        "name": "main",
        "namespace": var.operator_namespace
    },
    "spec": {
        "image": "quay.io/prometheus/alertmanager:v0.21.0",
        "nodeSelector": var.alertmanager_node_selector
        "replicas": var.alertmanager_replicas,
        "securityContext": {
            "fsGroup": 2000,
            "runAsNonRoot": true,
            "runAsUser": 1000
        },
        "serviceAccountName": "alertmanager-main",
        "version": "v0.21.0"
    }
}

}
