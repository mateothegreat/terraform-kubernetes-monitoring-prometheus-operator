resource "kubernetes_manifest" "kube-state-metrics-deployment" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
        "labels": {
            "app.kubernetes.io/name": "kube-state-metrics",
            "app.kubernetes.io/version": "1.9.7"
        },
        "name": "kube-state-metrics",
        "namespace": var.operator_namespace
    },
    "spec": {
        "replicas": 1,
        "selector": {
            "matchLabels": {
                "app.kubernetes.io/name": "kube-state-metrics"
            }
        },
        "template": {
            "metadata": {
                "labels": {
                    "app.kubernetes.io/name": "kube-state-metrics",
                    "app.kubernetes.io/version": "1.9.7"
                }
            },
            "spec": {
                "containers": [
                    {
                        "args": [
                            "--host=127.0.0.1",
                            "--port=8081",
                            "--telemetry-host=127.0.0.1",
                            "--telemetry-port=8082"
                        ],
                        "image": "quay.io/coreos/kube-state-metrics:v1.9.7",
                        "name": "kube-state-metrics",
                        "securityContext": {
                            "runAsUser": 65534
                        }
                    },
                    {
                        "args": [
                            "--logtostderr",
                            "--secure-listen-address=:8443",
                            "--tls-cipher-suites=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305",
                            "--upstream=http://127.0.0.1:8081/"
                        ],
                        "image": "quay.io/brancz/kube-rbac-proxy:v0.6.0",
                        "name": "kube-rbac-proxy-main",
                        "ports": [
                            {
                                "containerPort": 8443,
                                "name": "https-main",
                                "protocol": "TCP"
                            }
                        ],
                        "securityContext": {
                            "runAsUser": 65534
                        }
                    },
                    {
                        "args": [
                            "--logtostderr",
                            "--secure-listen-address=:9443",
                            "--tls-cipher-suites=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305",
                            "--upstream=http://127.0.0.1:8082/"
                        ],
                        "image": "quay.io/brancz/kube-rbac-proxy:v0.6.0",
                        "name": "kube-rbac-proxy-self",
                        "ports": [
                            {
                                "containerPort": 9443,
                                "name": "https-self",
                                "protocol": "TCP"
                            }
                        ],
                        "securityContext": {
                            "runAsUser": 65534
                        }
                    }
                ],
                "nodeSelector": {
                    "kubernetes.io/os": "linux"
                },
                "serviceAccountName": "kube-state-metrics"
            }
        }
    }
}

}
