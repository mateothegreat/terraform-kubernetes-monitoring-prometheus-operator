resource "kubernetes_manifest" "node-exporter-clusterRoleBinding" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRoleBinding",
    "metadata": {
        "name": "node-exporter"
    },
    "roleRef": {
        "apiGroup": "rbac.authorization.k8s.io",
        "kind": "ClusterRole",
        "name": "node-exporter"
    },
    "subjects": [
        {
            "kind": "ServiceAccount",
            "name": "node-exporter",
            "namespace": var.operator_namespace
        }
    ]
}

}
