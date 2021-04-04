resource "kubernetes_manifest" "prometheus-clusterRole" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRole",
    "metadata": {
        "name": "prometheus-k8s"
    },
    "rules": [
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "nodes/metrics"
            ],
            "verbs": [
                "get"
            ]
        },
        {
            "nonResourceURLs": [
                "/metrics"
            ],
            "verbs": [
                "get"
            ]
        },
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "services",
                "pods",
                "endpoints"
            ],
            "verbs": [
                "get",
                "list",
                "watch"
            ]
        }
    ]
}

}