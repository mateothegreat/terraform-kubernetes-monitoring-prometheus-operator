resource "kubernetes_manifest" "alertmanager-secret" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "v1",
    "data": {},
    "kind": "Secret",
    "metadata": {
        "name": "alertmanager-main",
        "namespace": var.operator_namespace
    },
    "stringData": {
        "alertmanager.yaml": "\"global\":\n  \"resolve_timeout\": \"5m\"\n\"inhibit_rules\":\n- \"equal\":\n  - \"namespace\"\n  - \"alertname\"\n  \"source_match\":\n    \"severity\": \"critical\"\n  \"target_match_re\":\n    \"severity\": \"warning|info\"\n- \"equal\":\n  - \"namespace\"\n  - \"alertname\"\n  \"source_match\":\n    \"severity\": \"warning\"\n  \"target_match_re\":\n    \"severity\": \"info\"\n\"receivers\":\n- \"name\": \"Default\"\n- \"name\": \"Watchdog\"\n- \"name\": \"Critical\"\n\"route\":\n  \"group_by\":\n  - \"namespace\"\n  \"group_interval\": \"5m\"\n  \"group_wait\": \"30s\"\n  \"receiver\": \"Default\"\n  \"repeat_interval\": \"12h\"\n  \"routes\":\n  - \"match\":\n      \"alertname\": \"Watchdog\"\n    \"receiver\": \"Watchdog\"\n  - \"match\":\n      \"severity\": \"critical\"\n    \"receiver\": \"Critical\""
    },
    "type": "Opaque"
}

}
