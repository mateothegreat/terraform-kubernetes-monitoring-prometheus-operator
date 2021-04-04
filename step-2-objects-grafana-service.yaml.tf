resource "kubernetes_manifest" "grafana-service" {

    count = var.grafana_enabled ? 1 : 0

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "app": "grafana"
        },
        "name": "grafana",
        "namespace": var.operator_namespace,
        "annotations": {
            "service.beta.kubernetes.io/aws-load-balancer-type": "nlb",
            "service.beta.kubernetes.io/aws-load-balancer-internal": "0.0.0.0/0"
        }
    },
    "spec": {
        "type": "LoadBalancer",
        "ports": [
            {
                "name": "http",
                "port": 80,
                "targetPort": "http"
            }
        ],
        "selector": {
            "app": "grafana"
        }
    }
}

}
