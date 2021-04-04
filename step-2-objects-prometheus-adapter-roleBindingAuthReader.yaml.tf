resource "kubernetes_manifest" "prometheus-adapter-roleBindingAuthReader" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "RoleBinding",
    "metadata": {
        "name": "resource-metrics-auth-reader",
        "namespace": "kube-system"
    },
    "roleRef": {
        "apiGroup": "rbac.authorization.k8s.io",
        "kind": "Role",
        "name": "extension-apiserver-authentication-reader"
    },
    "subjects": [
        {
            "kind": "ServiceAccount",
            "name": "prometheus-adapter",
            "namespace": var.operator_namespace
        }
    ]
}

}
