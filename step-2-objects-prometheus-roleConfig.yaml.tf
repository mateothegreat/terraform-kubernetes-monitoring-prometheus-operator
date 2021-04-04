resource "kubernetes_manifest" "prometheus-roleConfig" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "Role",
    "metadata": {
        "name": "prometheus-k8s-config",
        "namespace": var.operator_namespace
    },
    "rules": [
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "configmaps"
            ],
            "verbs": [
                "get"
            ]
        }
    ]
}

}
