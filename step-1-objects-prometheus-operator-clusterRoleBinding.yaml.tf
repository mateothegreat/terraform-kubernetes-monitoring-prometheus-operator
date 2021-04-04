resource "kubernetes_manifest" "prometheus-operator_clusterrolebinding" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRoleBinding",
    "metadata": {
        "labels": {
            "app.kubernetes.io/component": "controller",
            "app.kubernetes.io/name": "prometheus-operator",
            "app.kubernetes.io/version": "v0.42.1"
        },
        "name": "prometheus-operator"
    },
    "roleRef": {
        "apiGroup": "rbac.authorization.k8s.io",
        "kind": "ClusterRole",
        "name": "prometheus-operator"
    },
    "subjects": [
        {
            "kind": "ServiceAccount",
            "name": "prometheus-operator",
            "namespace": var.operator_namespace
        }
    ]
}

}
