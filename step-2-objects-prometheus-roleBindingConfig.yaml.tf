resource "kubernetes_manifest" "prometheus-roleBindingConfig" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "RoleBinding",
    "metadata": {
        "name": "prometheus-k8s-config",
        "namespace": var.operator_namespace
    },
    "roleRef": {
        "apiGroup": "rbac.authorization.k8s.io",
        "kind": "Role",
        "name": "prometheus-k8s-config"
    },
    "subjects": [
        {
            "kind": "ServiceAccount",
            "name": "prometheus-k8s",
            "namespace": var.operator_namespace
        }
    ]
}

}
