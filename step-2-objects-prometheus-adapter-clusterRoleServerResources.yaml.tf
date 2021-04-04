resource "kubernetes_manifest" "prometheus-adapter-clusterRoleServerResources" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRole",
    "metadata": {
        "name": "resource-metrics-server-resources"
    },
    "rules": [
        {
            "apiGroups": [
                "metrics.k8s.io"
            ],
            "resources": [
                "*"
            ],
            "verbs": [
                "*"
            ]
        }
    ]
}

}