resource "kubernetes_manifest" "prometheus-service" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "prometheus": "k8s"
        },
        "name": "prometheus-k8s",
        "namespace": var.operator_namespace,
        "annotations": {
            "service.beta.kubernetes.io/aws-load-balancer-type": "nlb",
            "service.beta.kubernetes.io/aws-load-balancer-internal": "0.0.0.0/0"
        }
    },
    "spec": {
        "type": "ClusterIP",
        "clusterIP": "None",
        "ports": [
            {
                "name": "web",
                "port": 9090,
                "targetPort": "web",
                "protocol": "TCP"
            }
        ],
        "selector": {
            "app": "prometheus",
            "prometheus": "k8s"
        }
    }
}

}
