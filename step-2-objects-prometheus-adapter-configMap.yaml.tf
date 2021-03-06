resource "kubernetes_manifest" "prometheus-adapter-configMap" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "data": {
        "config.yaml": "\"resourceRules\":\n  \"cpu\":\n    \"containerLabel\": \"container\"\n    \"containerQuery\": \"sum(irate(container_cpu_usage_seconds_total{<<.LabelMatchers>>,container!=\\\"POD\\\",container!=\\\"\\\",pod!=\\\"\\\"}[5m])) by (<<.GroupBy>>)\"\n    \"nodeQuery\": \"sum(1 - irate(node_cpu_seconds_total{mode=\\\"idle\\\"}[5m]) * on(namespace, pod) group_left(node) node_namespace_pod:kube_pod_info:{<<.LabelMatchers>>}) by (<<.GroupBy>>)\"\n    \"resources\":\n      \"overrides\":\n        \"namespace\":\n          \"resource\": \"namespace\"\n        \"node\":\n          \"resource\": \"node\"\n        \"pod\":\n          \"resource\": \"pod\"\n  \"memory\":\n    \"containerLabel\": \"container\"\n    \"containerQuery\": \"sum(container_memory_working_set_bytes{<<.LabelMatchers>>,container!=\\\"POD\\\",container!=\\\"\\\",pod!=\\\"\\\"}) by (<<.GroupBy>>)\"\n    \"nodeQuery\": \"sum(node_memory_MemTotal_bytes{job=\\\"node-exporter\\\",<<.LabelMatchers>>} - node_memory_MemAvailable_bytes{job=\\\"node-exporter\\\",<<.LabelMatchers>>}) by (<<.GroupBy>>)\"\n    \"resources\":\n      \"overrides\":\n        \"instance\":\n          \"resource\": \"node\"\n        \"namespace\":\n          \"resource\": \"namespace\"\n        \"pod\":\n          \"resource\": \"pod\"\n  \"window\": \"5m\""
    },
    "kind": "ConfigMap",
    "metadata": {
        "name": "adapter-config",
        "namespace": var.operator_namespace
    }
}

}
