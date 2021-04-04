resource "kubernetes_manifest" "prometheus-operator_clusterrole" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRole",
    "metadata": {
        "labels": {
            "app.kubernetes.io/component": "controller",
            "app.kubernetes.io/name": "prometheus-operator",
            "app.kubernetes.io/version": "v0.42.1"
        },
        "name": "prometheus-operator"
    },
    "rules": [
        {
            "apiGroups": [
                "monitoring.coreos.com"
            ],
            "resources": [
                "alertmanagers",
                "alertmanagers/finalizers",
                "prometheuses",
                "prometheuses/finalizers",
                "thanosrulers",
                "thanosrulers/finalizers",
                "servicemonitors",
                "podmonitors",
                "probes",
                "prometheusrules"
            ],
            "verbs": [
                "*"
            ]
        },
        {
            "apiGroups": [
                "apps"
            ],
            "resources": [
                "statefulsets"
            ],
            "verbs": [
                "*"
            ]
        },
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "configmaps",
                "secrets"
            ],
            "verbs": [
                "*"
            ]
        },
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "pods"
            ],
            "verbs": [
                "list",
                "delete"
            ]
        },
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "services",
                "services/finalizers",
                "endpoints"
            ],
            "verbs": [
                "get",
                "create",
                "update",
                "delete"
            ]
        },
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "nodes"
            ],
            "verbs": [
                "list",
                "watch"
            ]
        },
        {
            "apiGroups": [
                ""
            ],
            "resources": [
                "namespaces"
            ],
            "verbs": [
                "get",
                "list",
                "watch"
            ]
        },
        {
            "apiGroups": [
                "authentication.k8s.io"
            ],
            "resources": [
                "tokenreviews"
            ],
            "verbs": [
                "create"
            ]
        },
        {
            "apiGroups": [
                "authorization.k8s.io"
            ],
            "resources": [
                "subjectaccessreviews"
            ],
            "verbs": [
                "create"
            ]
        }
    ]
}

}