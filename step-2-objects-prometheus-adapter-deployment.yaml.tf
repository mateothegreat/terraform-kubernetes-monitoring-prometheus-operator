resource "kubernetes_manifest" "prometheus-adapter-deployment" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
        "name": "prometheus-adapter",
        "namespace": var.operator_namespace
    },
    "spec": {
        "replicas": 1,
        "selector": {
            "matchLabels": {
                "name": "prometheus-adapter"
            }
        },
        "strategy": {
            "rollingUpdate": {
                "maxSurge": 1,
                "maxUnavailable": 0
            }
        },
        "template": {
            "metadata": {
                "labels": {
                    "name": "prometheus-adapter"
                }
            },
            "spec": {
                "containers": [
                    {
                        "args": [
                            "--cert-dir=/var/run/serving-cert",
                            "--config=/etc/adapter/config.yaml",
                            "--logtostderr=true",
                            "--metrics-relist-interval=1m",
                            "--prometheus-url=http://prometheus-k8s.monitoring.svc.cluster.local:9090/",
                            "--secure-port=6443"
                        ],
                        "image": "directxman12/k8s-prometheus-adapter:v0.7.0",
                        "name": "prometheus-adapter",
                        "ports": [
                            {
                                "containerPort": 6443,
                                "protocol": "TCP"
                            }
                        ],
                        "volumeMounts": [
                            {
                                "mountPath": "/tmp",
                                "name": "tmpfs",
                                "readOnly": false
                            },
                            {
                                "mountPath": "/var/run/serving-cert",
                                "name": "volume-serving-cert",
                                "readOnly": false
                            },
                            {
                                "mountPath": "/etc/adapter",
                                "name": "config",
                                "readOnly": false
                            }
                        ]
                    }
                ],
                "nodeSelector": {
                    "role": "services"
                },
                "serviceAccountName": "prometheus-adapter",
                "volumes": [
                    {
                        "emptyDir": {},
                        "name": "tmpfs"
                    },
                    {
                        "emptyDir": {},
                        "name": "volume-serving-cert"
                    },
                    {
                        "configMap": {
                            "name": "adapter-config"
                        },
                        "name": "config"
                    }
                ]
            }
        }
    }
}

}
