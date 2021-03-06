resource "kubernetes_manifest" "prometheus-adapter-clusterRole" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRole",
    "metadata": {
        "name": "prometheus-adapter"
    },
    "rules": [
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "nodes",
                "namespaces",
                "pods",
                "services"
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