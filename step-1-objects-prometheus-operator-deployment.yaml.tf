resource "kubernetes_manifest" "prometheus-operator_deployment" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
        "labels": {
            "app.kubernetes.io/component": "controller",
            "app.kubernetes.io/name": "prometheus-operator",
            "app.kubernetes.io/version": "v0.42.1"
        },
        "name": "prometheus-operator",
        "namespace": var.operator_namespace
    },
    "spec": {
        "replicas": 1,
        "selector": {
            "matchLabels": {
                "app.kubernetes.io/component": "controller",
                "app.kubernetes.io/name": "prometheus-operator"
            }
        },
        "template": {
            "metadata": {
                "labels": {
                    "app.kubernetes.io/component": "controller",
                    "app.kubernetes.io/name": "prometheus-operator",
                    "app.kubernetes.io/version": "v0.42.1"
                }
            },
            "spec": {
                "containers": [
                    {
                        "args": [
                            "--kubelet-service=kube-system/kubelet",
                            "--logtostderr=true",
                            "--config-reloader-image=jimmidyson/configmap-reload:v0.4.0",
                            "--prometheus-config-reloader=quay.io/prometheus-operator/prometheus-config-reloader:v0.42.1"
                        ],
                        "image": "quay.io/prometheus-operator/prometheus-operator:v0.42.1",
                        "name": "prometheus-operator",
                        "ports": [
                            {
                                "containerPort": 8080,
                                "name": "http",
                                "protocol": "TCP"
                            }
                        ],
                        "resources": {
                            "limits": {
                                "cpu": "200m",
                                "memory": "200Mi"
                            },
                            "requests": {
                                "cpu": "100m",
                                "memory": "100Mi"
                            }
                        },
                        "securityContext": {
                            "allowPrivilegeEscalation": false
                        }
                    },
                    {
                        "args": [
                            "--logtostderr",
                            "--secure-listen-address=:8443",
                            "--tls-cipher-suites=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305",
                            "--upstream=http://127.0.0.1:8080/"
                        ],
                        "image": "quay.io/brancz/kube-rbac-proxy:v0.6.0",
                        "name": "kube-rbac-proxy",
                        "ports": [
                            {
                                "containerPort": 8443,
                                "name": "https",
                                "protocol": "TCP"
                            }
                        ],
                        "securityContext": {
                            "runAsUser": 65534
                        }
                    }
                ],
                "nodeSelector": {
                    "beta.kubernetes.io/os": "linux"
                },
                "securityContext": {
                    "runAsNonRoot": true,
                    "runAsUser": 65534
                },
                "serviceAccountName": "prometheus-operator"
            }
        }
    }
}

}