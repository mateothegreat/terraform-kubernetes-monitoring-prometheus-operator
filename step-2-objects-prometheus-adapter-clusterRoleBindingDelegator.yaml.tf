resource "kubernetes_manifest" "prometheus-adapter-clusterRoleBindingDelegator" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRoleBinding",
    "metadata": {
        "name": "resource-metrics:system:auth-delegator"
    },
    "roleRef": {
        "apiGroup": "rbac.authorization.k8s.io",
        "kind": "ClusterRole",
        "name": "system:auth-delegator"
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
