resource "kubernetes_manifest" "prometheus-rules" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "monitoring.coreos.com/v1",
    "kind": "PrometheusRule",
    "metadata": {
        "labels": {
            "prometheus": "k8s",
            "role": "alert-rules"
        },
        "name": "prometheus-k8s-rules",
        "namespace": var.operator_namespace
    },
    "spec": {
        "groups": [
            {
                "name": "node-exporter.rules",
                "rules": [
                    {
                        "expr": "count without (cpu) (\n  count without (mode) (\n    node_cpu_seconds_total{job=\"node-exporter\"}\n  )\n)\n",
                        "record": "instance:node_num_cpu:sum"
                    },
                    {
                        "expr": "1 - avg without (cpu, mode) (\n  rate(node_cpu_seconds_total{job=\"node-exporter\", mode=\"idle\"}[1m])\n)\n",
                        "record": "instance:node_cpu_utilisation:rate1m"
                    },
                    {
                        "expr": "(\n  node_load1{job=\"node-exporter\"}\n/\n  instance:node_num_cpu:sum{job=\"node-exporter\"}\n)\n",
                        "record": "instance:node_load1_per_cpu:ratio"
                    },
                    {
                        "expr": "1 - (\n  node_memory_MemAvailable_bytes{job=\"node-exporter\"}\n/\n  node_memory_MemTotal_bytes{job=\"node-exporter\"}\n)\n",
                        "record": "instance:node_memory_utilisation:ratio"
                    },
                    {
                        "expr": "rate(node_vmstat_pgmajfault{job=\"node-exporter\"}[1m])\n",
                        "record": "instance:node_vmstat_pgmajfault:rate1m"
                    },
                    {
                        "expr": "rate(node_disk_io_time_seconds_total{job=\"node-exporter\", device=~\"nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+\"}[1m])\n",
                        "record": "instance_device:node_disk_io_time_seconds:rate1m"
                    },
                    {
                        "expr": "rate(node_disk_io_time_weighted_seconds_total{job=\"node-exporter\", device=~\"nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+\"}[1m])\n",
                        "record": "instance_device:node_disk_io_time_weighted_seconds:rate1m"
                    },
                    {
                        "expr": "sum without (device) (\n  rate(node_network_receive_bytes_total{job=\"node-exporter\", device!=\"lo\"}[1m])\n)\n",
                        "record": "instance:node_network_receive_bytes_excluding_lo:rate1m"
                    },
                    {
                        "expr": "sum without (device) (\n  rate(node_network_transmit_bytes_total{job=\"node-exporter\", device!=\"lo\"}[1m])\n)\n",
                        "record": "instance:node_network_transmit_bytes_excluding_lo:rate1m"
                    },
                    {
                        "expr": "sum without (device) (\n  rate(node_network_receive_drop_total{job=\"node-exporter\", device!=\"lo\"}[1m])\n)\n",
                        "record": "instance:node_network_receive_drop_excluding_lo:rate1m"
                    },
                    {
                        "expr": "sum without (device) (\n  rate(node_network_transmit_drop_total{job=\"node-exporter\", device!=\"lo\"}[1m])\n)\n",
                        "record": "instance:node_network_transmit_drop_excluding_lo:rate1m"
                    }
                ]
            },
            {
                "name": "kube-apiserver.rules",
                "rules": [
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\"}[1d]))\n    -\n    (\n      (\n        sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[1d]))\n        or\n        vector(0)\n      )\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[1d]))\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[1d]))\n    )\n  )\n  +\n  # errors\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[1d]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[1d]))\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "apiserver_request:burnrate1d"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\"}[1h]))\n    -\n    (\n      (\n        sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[1h]))\n        or\n        vector(0)\n      )\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[1h]))\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[1h]))\n    )\n  )\n  +\n  # errors\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[1h]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[1h]))\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "apiserver_request:burnrate1h"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\"}[2h]))\n    -\n    (\n      (\n        sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[2h]))\n        or\n        vector(0)\n      )\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[2h]))\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[2h]))\n    )\n  )\n  +\n  # errors\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[2h]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[2h]))\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "apiserver_request:burnrate2h"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\"}[30m]))\n    -\n    (\n      (\n        sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[30m]))\n        or\n        vector(0)\n      )\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[30m]))\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[30m]))\n    )\n  )\n  +\n  # errors\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[30m]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[30m]))\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "apiserver_request:burnrate30m"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\"}[3d]))\n    -\n    (\n      (\n        sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[3d]))\n        or\n        vector(0)\n      )\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[3d]))\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[3d]))\n    )\n  )\n  +\n  # errors\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[3d]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[3d]))\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "apiserver_request:burnrate3d"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\"}[5m]))\n    -\n    (\n      (\n        sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[5m]))\n        or\n        vector(0)\n      )\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[5m]))\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[5m]))\n    )\n  )\n  +\n  # errors\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[5m]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[5m]))\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "apiserver_request:burnrate5m"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\"}[6h]))\n    -\n    (\n      (\n        sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[6h]))\n        or\n        vector(0)\n      )\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[6h]))\n      +\n      sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[6h]))\n    )\n  )\n  +\n  # errors\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\",code=~\"5..\"}[6h]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[6h]))\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "apiserver_request:burnrate6h"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[1d]))\n    -\n    sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[1d]))\n  )\n  +\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[1d]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[1d]))\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "apiserver_request:burnrate1d"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[1h]))\n    -\n    sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[1h]))\n  )\n  +\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[1h]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[1h]))\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "apiserver_request:burnrate1h"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[2h]))\n    -\n    sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[2h]))\n  )\n  +\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[2h]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[2h]))\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "apiserver_request:burnrate2h"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[30m]))\n    -\n    sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[30m]))\n  )\n  +\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[30m]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[30m]))\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "apiserver_request:burnrate30m"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[3d]))\n    -\n    sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[3d]))\n  )\n  +\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[3d]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[3d]))\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "apiserver_request:burnrate3d"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[5m]))\n    -\n    sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[5m]))\n  )\n  +\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[5m]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[5m]))\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "apiserver_request:burnrate5m"
                    },
                    {
                        "expr": "(\n  (\n    # too slow\n    sum(rate(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[6h]))\n    -\n    sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[6h]))\n  )\n  +\n  sum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\",code=~\"5..\"}[6h]))\n)\n/\nsum(rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[6h]))\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "apiserver_request:burnrate6h"
                    },
                    {
                        "expr": "sum by (code,resource) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"LIST|GET\"}[5m]))\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "code_resource:apiserver_request_total:rate5m"
                    },
                    {
                        "expr": "sum by (code,resource) (rate(apiserver_request_total{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[5m]))\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "code_resource:apiserver_request_total:rate5m"
                    },
                    {
                        "expr": "histogram_quantile(0.99, sum by (le, resource) (rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\"}[5m]))) > 0\n",
                        "labels": {
                            "quantile": "0.99",
                            "verb": "read"
                        },
                        "record": "cluster_quantile:apiserver_request_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.99, sum by (le, resource) (rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"POST|PUT|PATCH|DELETE\"}[5m]))) > 0\n",
                        "labels": {
                            "quantile": "0.99",
                            "verb": "write"
                        },
                        "record": "cluster_quantile:apiserver_request_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "sum(rate(apiserver_request_duration_seconds_sum{subresource!=\"log\",verb!~\"LIST|WATCH|WATCHLIST|DELETECOLLECTION|PROXY|CONNECT\"}[5m])) without(instance, pod)\n/\nsum(rate(apiserver_request_duration_seconds_count{subresource!=\"log\",verb!~\"LIST|WATCH|WATCHLIST|DELETECOLLECTION|PROXY|CONNECT\"}[5m])) without(instance, pod)\n",
                        "record": "cluster:apiserver_request_duration_seconds:mean5m"
                    },
                    {
                        "expr": "histogram_quantile(0.99, sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",subresource!=\"log\",verb!~\"LIST|WATCH|WATCHLIST|DELETECOLLECTION|PROXY|CONNECT\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.99"
                        },
                        "record": "cluster_quantile:apiserver_request_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.9, sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",subresource!=\"log\",verb!~\"LIST|WATCH|WATCHLIST|DELETECOLLECTION|PROXY|CONNECT\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.9"
                        },
                        "record": "cluster_quantile:apiserver_request_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.5, sum(rate(apiserver_request_duration_seconds_bucket{job=\"apiserver\",subresource!=\"log\",verb!~\"LIST|WATCH|WATCHLIST|DELETECOLLECTION|PROXY|CONNECT\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.5"
                        },
                        "record": "cluster_quantile:apiserver_request_duration_seconds:histogram_quantile"
                    }
                ]
            },
            {
                "interval": "3m",
                "name": "kube-apiserver-availability.rules",
                "rules": [
                    {
                        "expr": "1 - (\n  (\n    # write too slow\n    sum(increase(apiserver_request_duration_seconds_count{verb=~\"POST|PUT|PATCH|DELETE\"}[30d]))\n    -\n    sum(increase(apiserver_request_duration_seconds_bucket{verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[30d]))\n  ) +\n  (\n    # read too slow\n    sum(increase(apiserver_request_duration_seconds_count{verb=~\"LIST|GET\"}[30d]))\n    -\n    (\n      (\n        sum(increase(apiserver_request_duration_seconds_bucket{verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[30d]))\n        or\n        vector(0)\n      )\n      +\n      sum(increase(apiserver_request_duration_seconds_bucket{verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[30d]))\n      +\n      sum(increase(apiserver_request_duration_seconds_bucket{verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[30d]))\n    )\n  ) +\n  # errors\n  sum(code:apiserver_request_total:increase30d{code=~\"5..\"} or vector(0))\n)\n/\nsum(code:apiserver_request_total:increase30d)\n",
                        "labels": {
                            "verb": "all"
                        },
                        "record": "apiserver_request:availability30d"
                    },
                    {
                        "expr": "1 - (\n  sum(increase(apiserver_request_duration_seconds_count{job=\"apiserver\",verb=~\"LIST|GET\"}[30d]))\n  -\n  (\n    # too slow\n    (\n      sum(increase(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=~\"resource|\",le=\"0.1\"}[30d]))\n      or\n      vector(0)\n    )\n    +\n    sum(increase(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"namespace\",le=\"0.5\"}[30d]))\n    +\n    sum(increase(apiserver_request_duration_seconds_bucket{job=\"apiserver\",verb=~\"LIST|GET\",scope=\"cluster\",le=\"5\"}[30d]))\n  )\n  +\n  # errors\n  sum(code:apiserver_request_total:increase30d{verb=\"read\",code=~\"5..\"} or vector(0))\n)\n/\nsum(code:apiserver_request_total:increase30d{verb=\"read\"})\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "apiserver_request:availability30d"
                    },
                    {
                        "expr": "1 - (\n  (\n    # too slow\n    sum(increase(apiserver_request_duration_seconds_count{verb=~\"POST|PUT|PATCH|DELETE\"}[30d]))\n    -\n    sum(increase(apiserver_request_duration_seconds_bucket{verb=~\"POST|PUT|PATCH|DELETE\",le=\"1\"}[30d]))\n  )\n  +\n  # errors\n  sum(code:apiserver_request_total:increase30d{verb=\"write\",code=~\"5..\"} or vector(0))\n)\n/\nsum(code:apiserver_request_total:increase30d{verb=\"write\"})\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "apiserver_request:availability30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"LIST\",code=~\"2..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"GET\",code=~\"2..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"POST\",code=~\"2..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"PUT\",code=~\"2..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"PATCH\",code=~\"2..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"DELETE\",code=~\"2..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"LIST\",code=~\"3..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"GET\",code=~\"3..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"POST\",code=~\"3..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"PUT\",code=~\"3..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"PATCH\",code=~\"3..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"DELETE\",code=~\"3..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"LIST\",code=~\"4..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"GET\",code=~\"4..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"POST\",code=~\"4..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"PUT\",code=~\"4..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"PATCH\",code=~\"4..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"DELETE\",code=~\"4..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"LIST\",code=~\"5..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"GET\",code=~\"5..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"POST\",code=~\"5..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"PUT\",code=~\"5..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"PATCH\",code=~\"5..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code, verb) (increase(apiserver_request_total{job=\"apiserver\",verb=\"DELETE\",code=~\"5..\"}[30d]))\n",
                        "record": "code_verb:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code) (code_verb:apiserver_request_total:increase30d{verb=~\"LIST|GET\"})\n",
                        "labels": {
                            "verb": "read"
                        },
                        "record": "code:apiserver_request_total:increase30d"
                    },
                    {
                        "expr": "sum by (code) (code_verb:apiserver_request_total:increase30d{verb=~\"POST|PUT|PATCH|DELETE\"})\n",
                        "labels": {
                            "verb": "write"
                        },
                        "record": "code:apiserver_request_total:increase30d"
                    }
                ]
            },
            {
                "name": "k8s.rules",
                "rules": [
                    {
                        "expr": "sum(rate(container_cpu_usage_seconds_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\", container!=\"POD\"}[5m])) by (namespace)\n",
                        "record": "namespace:container_cpu_usage_seconds_total:sum_rate"
                    },
                    {
                        "expr": "sum by (cluster, namespace, pod, container) (\n  rate(container_cpu_usage_seconds_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\", container!=\"POD\"}[5m])\n) * on (cluster, namespace, pod) group_left(node) topk by (cluster, namespace, pod) (\n  1, max by(cluster, namespace, pod, node) (kube_pod_info{node!=\"\"})\n)\n",
                        "record": "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_rate"
                    },
                    {
                        "expr": "container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}\n* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,\n  max by(namespace, pod, node) (kube_pod_info{node!=\"\"})\n)\n",
                        "record": "node_namespace_pod_container:container_memory_working_set_bytes"
                    },
                    {
                        "expr": "container_memory_rss{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}\n* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,\n  max by(namespace, pod, node) (kube_pod_info{node!=\"\"})\n)\n",
                        "record": "node_namespace_pod_container:container_memory_rss"
                    },
                    {
                        "expr": "container_memory_cache{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}\n* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,\n  max by(namespace, pod, node) (kube_pod_info{node!=\"\"})\n)\n",
                        "record": "node_namespace_pod_container:container_memory_cache"
                    },
                    {
                        "expr": "container_memory_swap{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\"}\n* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,\n  max by(namespace, pod, node) (kube_pod_info{node!=\"\"})\n)\n",
                        "record": "node_namespace_pod_container:container_memory_swap"
                    },
                    {
                        "expr": "sum(container_memory_usage_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", image!=\"\", container!=\"POD\"}) by (namespace)\n",
                        "record": "namespace:container_memory_usage_bytes:sum"
                    },
                    {
                        "expr": "sum by (namespace) (\n    sum by (namespace, pod) (\n        max by (namespace, pod, container) (\n            kube_pod_container_resource_requests_memory_bytes{job=\"kube-state-metrics\"}\n        ) * on(namespace, pod) group_left() max by (namespace, pod) (\n            kube_pod_status_phase{phase=~\"Pending|Running\"} == 1\n        )\n    )\n)\n",
                        "record": "namespace:kube_pod_container_resource_requests_memory_bytes:sum"
                    },
                    {
                        "expr": "sum by (namespace) (\n    sum by (namespace, pod) (\n        max by (namespace, pod, container) (\n            kube_pod_container_resource_requests_cpu_cores{job=\"kube-state-metrics\"}\n        ) * on(namespace, pod) group_left() max by (namespace, pod) (\n          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1\n        )\n    )\n)\n",
                        "record": "namespace:kube_pod_container_resource_requests_cpu_cores:sum"
                    },
                    {
                        "expr": "max by (cluster, namespace, workload, pod) (\n  label_replace(\n    label_replace(\n      kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"ReplicaSet\"},\n      \"replicaset\", \"$1\", \"owner_name\", \"(.*)\"\n    ) * on(replicaset, namespace) group_left(owner_name) topk by(replicaset, namespace) (\n      1, max by (replicaset, namespace, owner_name) (\n        kube_replicaset_owner{job=\"kube-state-metrics\"}\n      )\n    ),\n    \"workload\", \"$1\", \"owner_name\", \"(.*)\"\n  )\n)\n",
                        "labels": {
                            "workload_type": "deployment"
                        },
                        "record": "namespace_workload_pod:kube_pod_owner:relabel"
                    },
                    {
                        "expr": "max by (cluster, namespace, workload, pod) (\n  label_replace(\n    kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"DaemonSet\"},\n    \"workload\", \"$1\", \"owner_name\", \"(.*)\"\n  )\n)\n",
                        "labels": {
                            "workload_type": "daemonset"
                        },
                        "record": "namespace_workload_pod:kube_pod_owner:relabel"
                    },
                    {
                        "expr": "max by (cluster, namespace, workload, pod) (\n  label_replace(\n    kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"StatefulSet\"},\n    \"workload\", \"$1\", \"owner_name\", \"(.*)\"\n  )\n)\n",
                        "labels": {
                            "workload_type": "statefulset"
                        },
                        "record": "namespace_workload_pod:kube_pod_owner:relabel"
                    }
                ]
            },
            {
                "name": "kube-scheduler.rules",
                "rules": [
                    {
                        "expr": "histogram_quantile(0.99, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.99"
                        },
                        "record": "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.99, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.99"
                        },
                        "record": "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.99, sum(rate(scheduler_binding_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.99"
                        },
                        "record": "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.9, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.9"
                        },
                        "record": "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.9, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.9"
                        },
                        "record": "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.9, sum(rate(scheduler_binding_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.9"
                        },
                        "record": "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.5, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.5"
                        },
                        "record": "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.5, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.5"
                        },
                        "record": "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.5, sum(rate(scheduler_binding_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance, pod))\n",
                        "labels": {
                            "quantile": "0.5"
                        },
                        "record": "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
                    }
                ]
            },
            {
                "name": "node.rules",
                "rules": [
                    {
                        "expr": "sum(min(kube_pod_info{node!=\"\"}) by (cluster, node))\n",
                        "record": ":kube_pod_info_node_count:"
                    },
                    {
                        "expr": "topk by(namespace, pod) (1,\n  max by (node, namespace, pod) (\n    label_replace(kube_pod_info{job=\"kube-state-metrics\",node!=\"\"}, \"pod\", \"$1\", \"pod\", \"(.*)\")\n))\n",
                        "record": "node_namespace_pod:kube_pod_info:"
                    },
                    {
                        "expr": "count by (cluster, node) (sum by (node, cpu) (\n  node_cpu_seconds_total{job=\"node-exporter\"}\n* on (namespace, pod) group_left(node)\n  node_namespace_pod:kube_pod_info:\n))\n",
                        "record": "node:node_num_cpu:sum"
                    },
                    {
                        "expr": "sum(\n  node_memory_MemAvailable_bytes{job=\"node-exporter\"} or\n  (\n    node_memory_Buffers_bytes{job=\"node-exporter\"} +\n    node_memory_Cached_bytes{job=\"node-exporter\"} +\n    node_memory_MemFree_bytes{job=\"node-exporter\"} +\n    node_memory_Slab_bytes{job=\"node-exporter\"}\n  )\n) by (cluster)\n",
                        "record": ":node_memory_MemAvailable_bytes:sum"
                    }
                ]
            },
            {
                "name": "kubelet.rules",
                "rules": [
                    {
                        "expr": "histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (instance, le) * on(instance) group_left(node) kubelet_node_name{job=\"kubelet\", metrics_path=\"/metrics\"})\n",
                        "labels": {
                            "quantile": "0.99"
                        },
                        "record": "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.9, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (instance, le) * on(instance) group_left(node) kubelet_node_name{job=\"kubelet\", metrics_path=\"/metrics\"})\n",
                        "labels": {
                            "quantile": "0.9"
                        },
                        "record": "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
                    },
                    {
                        "expr": "histogram_quantile(0.5, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (instance, le) * on(instance) group_left(node) kubelet_node_name{job=\"kubelet\", metrics_path=\"/metrics\"})\n",
                        "labels": {
                            "quantile": "0.5"
                        },
                        "record": "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
                    }
                ]
            },
            {
                "name": "kube-prometheus-node-recording.rules",
                "rules": [
                    {
                        "expr": "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\"}[3m])) BY (instance)",
                        "record": "instance:node_cpu:rate:sum"
                    },
                    {
                        "expr": "sum(rate(node_network_receive_bytes_total[3m])) BY (instance)",
                        "record": "instance:node_network_receive_bytes:rate:sum"
                    },
                    {
                        "expr": "sum(rate(node_network_transmit_bytes_total[3m])) BY (instance)",
                        "record": "instance:node_network_transmit_bytes:rate:sum"
                    },
                    {
                        "expr": "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\"}[5m])) WITHOUT (cpu, mode) / ON(instance) GROUP_LEFT() count(sum(node_cpu_seconds_total) BY (instance, cpu)) BY (instance)",
                        "record": "instance:node_cpu:ratio"
                    },
                    {
                        "expr": "sum(rate(node_cpu_seconds_total{mode!=\"idle\",mode!=\"iowait\"}[5m]))",
                        "record": "cluster:node_cpu:sum_rate5m"
                    },
                    {
                        "expr": "cluster:node_cpu_seconds_total:rate5m / count(sum(node_cpu_seconds_total) BY (instance, cpu))",
                        "record": "cluster:node_cpu:ratio"
                    }
                ]
            },
            {
                "name": "kube-prometheus-general.rules",
                "rules": [
                    {
                        "expr": "count without(instance, pod, node) (up == 1)",
                        "record": "count:up1"
                    },
                    {
                        "expr": "count without(instance, pod, node) (up == 0)",
                        "record": "count:up0"
                    }
                ]
            },
            {
                "name": "kube-state-metrics",
                "rules": [
                    {
                        "alert": "KubeStateMetricsListErrors",
                        "annotations": {
                            "description": "kube-state-metrics is experiencing errors at an elevated rate in list operations. This is likely causing it to not be able to expose metrics about Kubernetes objects correctly or at all.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubestatemetricslisterrors",
                            "summary": "kube-state-metrics is experiencing errors in list operations."
                        },
                        "expr": "(sum(rate(kube_state_metrics_list_total{job=\"kube-state-metrics\",result=\"error\"}[5m]))\n  /\nsum(rate(kube_state_metrics_list_total{job=\"kube-state-metrics\"}[5m])))\n> 0.01\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "KubeStateMetricsWatchErrors",
                        "annotations": {
                            "description": "kube-state-metrics is experiencing errors at an elevated rate in watch operations. This is likely causing it to not be able to expose metrics about Kubernetes objects correctly or at all.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubestatemetricswatcherrors",
                            "summary": "kube-state-metrics is experiencing errors in watch operations."
                        },
                        "expr": "(sum(rate(kube_state_metrics_watch_total{job=\"kube-state-metrics\",result=\"error\"}[5m]))\n  /\nsum(rate(kube_state_metrics_watch_total{job=\"kube-state-metrics\"}[5m])))\n> 0.01\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    }
                ]
            },
            {
                "name": "node-exporter",
                "rules": [
                    {
                        "alert": "NodeFilesystemSpaceFillingUp",
                        "annotations": {
                            "description": "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left and is filling up.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodefilesystemspacefillingup",
                            "summary": "Filesystem is predicted to run out of space within the next 24 hours."
                        },
                        "expr": "(\n  node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\"} / node_filesystem_size_bytes{job=\"node-exporter\",fstype!=\"\"} * 100 < 40\nand\n  predict_linear(node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\"}[6h], 24*60*60) < 0\nand\n  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\"} == 0\n)\n",
                        "for": "1h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeFilesystemSpaceFillingUp",
                        "annotations": {
                            "description": "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left and is filling up fast.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodefilesystemspacefillingup",
                            "summary": "Filesystem is predicted to run out of space within the next 4 hours."
                        },
                        "expr": "(\n  node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\"} / node_filesystem_size_bytes{job=\"node-exporter\",fstype!=\"\"} * 100 < 15\nand\n  predict_linear(node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\"}[6h], 4*60*60) < 0\nand\n  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\"} == 0\n)\n",
                        "for": "1h",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "NodeFilesystemAlmostOutOfSpace",
                        "annotations": {
                            "description": "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodefilesystemalmostoutofspace",
                            "summary": "Filesystem has less than 5% space left."
                        },
                        "expr": "(\n  node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\"} / node_filesystem_size_bytes{job=\"node-exporter\",fstype!=\"\"} * 100 < 5\nand\n  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\"} == 0\n)\n",
                        "for": "1h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeFilesystemAlmostOutOfSpace",
                        "annotations": {
                            "description": "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodefilesystemalmostoutofspace",
                            "summary": "Filesystem has less than 3% space left."
                        },
                        "expr": "(\n  node_filesystem_avail_bytes{job=\"node-exporter\",fstype!=\"\"} / node_filesystem_size_bytes{job=\"node-exporter\",fstype!=\"\"} * 100 < 3\nand\n  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\"} == 0\n)\n",
                        "for": "1h",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "NodeFilesystemFilesFillingUp",
                        "annotations": {
                            "description": "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left and is filling up.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodefilesystemfilesfillingup",
                            "summary": "Filesystem is predicted to run out of inodes within the next 24 hours."
                        },
                        "expr": "(\n  node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\"} / node_filesystem_files{job=\"node-exporter\",fstype!=\"\"} * 100 < 40\nand\n  predict_linear(node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\"}[6h], 24*60*60) < 0\nand\n  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\"} == 0\n)\n",
                        "for": "1h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeFilesystemFilesFillingUp",
                        "annotations": {
                            "description": "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left and is filling up fast.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodefilesystemfilesfillingup",
                            "summary": "Filesystem is predicted to run out of inodes within the next 4 hours."
                        },
                        "expr": "(\n  node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\"} / node_filesystem_files{job=\"node-exporter\",fstype!=\"\"} * 100 < 20\nand\n  predict_linear(node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\"}[6h], 4*60*60) < 0\nand\n  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\"} == 0\n)\n",
                        "for": "1h",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "NodeFilesystemAlmostOutOfFiles",
                        "annotations": {
                            "description": "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodefilesystemalmostoutoffiles",
                            "summary": "Filesystem has less than 5% inodes left."
                        },
                        "expr": "(\n  node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\"} / node_filesystem_files{job=\"node-exporter\",fstype!=\"\"} * 100 < 5\nand\n  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\"} == 0\n)\n",
                        "for": "1h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeFilesystemAlmostOutOfFiles",
                        "annotations": {
                            "description": "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodefilesystemalmostoutoffiles",
                            "summary": "Filesystem has less than 3% inodes left."
                        },
                        "expr": "(\n  node_filesystem_files_free{job=\"node-exporter\",fstype!=\"\"} / node_filesystem_files{job=\"node-exporter\",fstype!=\"\"} * 100 < 3\nand\n  node_filesystem_readonly{job=\"node-exporter\",fstype!=\"\"} == 0\n)\n",
                        "for": "1h",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "NodeNetworkReceiveErrs",
                        "annotations": {
                            "description": "{{ $labels.instance }} interface {{ $labels.device }} has encountered {{ printf \"%.0f\" $value }} receive errors in the last two minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodenetworkreceiveerrs",
                            "summary": "Network interface is reporting many receive errors."
                        },
                        "expr": "rate(node_network_receive_errs_total[2m]) / rate(node_network_receive_packets_total[2m]) > 0.01\n",
                        "for": "1h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeNetworkTransmitErrs",
                        "annotations": {
                            "description": "{{ $labels.instance }} interface {{ $labels.device }} has encountered {{ printf \"%.0f\" $value }} transmit errors in the last two minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodenetworktransmiterrs",
                            "summary": "Network interface is reporting many transmit errors."
                        },
                        "expr": "rate(node_network_transmit_errs_total[2m]) / rate(node_network_transmit_packets_total[2m]) > 0.01\n",
                        "for": "1h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeHighNumberConntrackEntriesUsed",
                        "annotations": {
                            "description": "{{ $value | humanizePercentage }} of conntrack entries are used.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodehighnumberconntrackentriesused",
                            "summary": "Number of conntrack are getting close to the limit."
                        },
                        "expr": "(node_nf_conntrack_entries / node_nf_conntrack_entries_limit) > 0.75\n",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeTextFileCollectorScrapeError",
                        "annotations": {
                            "description": "Node Exporter text file collector failed to scrape.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodetextfilecollectorscrapeerror",
                            "summary": "Node Exporter text file collector failed to scrape."
                        },
                        "expr": "node_textfile_scrape_error{job=\"node-exporter\"} == 1\n",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeClockSkewDetected",
                        "annotations": {
                            "message": "Clock on {{ $labels.instance }} is out of sync by more than 300s. Ensure NTP is configured correctly on this host.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodeclockskewdetected",
                            "summary": "Clock skew detected."
                        },
                        "expr": "(\n  node_timex_offset_seconds > 0.05\nand\n  deriv(node_timex_offset_seconds[5m]) >= 0\n)\nor\n(\n  node_timex_offset_seconds < -0.05\nand\n  deriv(node_timex_offset_seconds[5m]) <= 0\n)\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeClockNotSynchronising",
                        "annotations": {
                            "message": "Clock on {{ $labels.instance }} is not synchronising. Ensure NTP is configured on this host.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-nodeclocknotsynchronising",
                            "summary": "Clock not synchronising."
                        },
                        "expr": "min_over_time(node_timex_sync_status[5m]) == 0\nand\nnode_timex_maxerror_seconds >= 16\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "NodeRAIDDegraded",
                        "annotations": {
                            "description": "RAID array '{{ $labels.device }}' on {{ $labels.instance }} is in degraded state due to one or more disks failures. Number of spare drives is insufficient to fix issue automatically.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-noderaiddegraded",
                            "summary": "RAID Array is degraded"
                        },
                        "expr": "node_md_disks_required - ignoring (state) (node_md_disks{state=\"active\"}) > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "NodeRAIDDiskFailure",
                        "annotations": {
                            "description": "At least one device in RAID array on {{ $labels.instance }} failed. Array '{{ $labels.device }}' needs attention and possibly a disk swap.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-noderaiddiskfailure",
                            "summary": "Failed device in RAID array"
                        },
                        "expr": "node_md_disks{state=\"fail\"} > 0\n",
                        "labels": {
                            "severity": "warning"
                        }
                    }
                ]
            },
            {
                "name": "prometheus-operator",
                "rules": [
                    {
                        "alert": "PrometheusOperatorListErrors",
                        "annotations": {
                            "description": "Errors while performing List operations in controller {{$labels.controller}} in {{$labels.namespace}} namespace.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-prometheusoperatorlisterrors",
                            "summary": "Errors while performing list operations in controller."
                        },
                        "expr": "(sum by (controller,namespace) (rate(prometheus_operator_list_operations_failed_total{job=\"prometheus-operator\",namespace=\"monitoring\"}[10m])) / sum by (controller,namespace) (rate(prometheus_operator_list_operations_total{job=\"prometheus-operator\",namespace=\"monitoring\"}[10m]))) > 0.4\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusOperatorWatchErrors",
                        "annotations": {
                            "description": "Errors while performing watch operations in controller {{$labels.controller}} in {{$labels.namespace}} namespace.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-prometheusoperatorwatcherrors",
                            "summary": "Errors while performing watch operations in controller."
                        },
                        "expr": "(sum by (controller,namespace) (rate(prometheus_operator_watch_operations_failed_total{job=\"prometheus-operator\",namespace=\"monitoring\"}[10m])) / sum by (controller,namespace) (rate(prometheus_operator_watch_operations_total{job=\"prometheus-operator\",namespace=\"monitoring\"}[10m]))) > 0.4\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusOperatorReconcileErrors",
                        "annotations": {
                            "description": "{{ $value | humanizePercentage }} of reconciling operations failed for {{ $labels.controller }} controller in {{ $labels.namespace }} namespace.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-prometheusoperatorreconcileerrors",
                            "summary": "Errors while reconciling controller."
                        },
                        "expr": "(sum by (controller,namespace) (rate(prometheus_operator_reconcile_errors_total{job=\"prometheus-operator\",namespace=\"monitoring\"}[5m]))) / (sum by (controller,namespace) (rate(prometheus_operator_reconcile_operations_total{job=\"prometheus-operator\",namespace=\"monitoring\"}[5m]))) > 0.1\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusOperatorNodeLookupErrors",
                        "annotations": {
                            "description": "Errors while reconciling Prometheus in {{ $labels.namespace }} Namespace.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-prometheusoperatornodelookuperrors",
                            "summary": "Errors while reconciling Prometheus."
                        },
                        "expr": "rate(prometheus_operator_node_address_lookup_errors_total{job=\"prometheus-operator\",namespace=\"monitoring\"}[5m]) > 0.1\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    }
                ]
            },
            {
                "name": "kubernetes-apps",
                "rules": [
                    {
                        "alert": "KubePodCrashLooping",
                        "annotations": {
                            "description": "Pod {{ $labels.namespace }}/{{ $labels.pod }} ({{ $labels.container }}) is restarting {{ printf \"%.2f\" $value }} times / 5 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubepodcrashlooping",
                            "summary": "Pod is crash looping."
                        },
                        "expr": "rate(kube_pod_container_status_restarts_total{job=\"kube-state-metrics\"}[5m]) * 60 * 5 > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubePodNotReady",
                        "annotations": {
                            "description": "Pod {{ $labels.namespace }}/{{ $labels.pod }} has been in a non-ready state for longer than 15 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubepodnotready",
                            "summary": "Pod has been in a non-ready state for more than 15 minutes."
                        },
                        "expr": "sum by (namespace, pod) (\n  max by(namespace, pod) (\n    kube_pod_status_phase{job=\"kube-state-metrics\", phase=~\"Pending|Unknown\"}\n  ) * on(namespace, pod) group_left(owner_kind) topk by(namespace, pod) (\n    1, max by(namespace, pod, owner_kind) (kube_pod_owner{owner_kind!=\"Job\"})\n  )\n) > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeDeploymentGenerationMismatch",
                        "annotations": {
                            "description": "Deployment generation for {{ $labels.namespace }}/{{ $labels.deployment }} does not match, this indicates that the Deployment has failed but has not been rolled back.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubedeploymentgenerationmismatch",
                            "summary": "Deployment generation mismatch due to possible roll-back"
                        },
                        "expr": "kube_deployment_status_observed_generation{job=\"kube-state-metrics\"}\n  !=\nkube_deployment_metadata_generation{job=\"kube-state-metrics\"}\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeDeploymentReplicasMismatch",
                        "annotations": {
                            "description": "Deployment {{ $labels.namespace }}/{{ $labels.deployment }} has not matched the expected number of replicas for longer than 15 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubedeploymentreplicasmismatch",
                            "summary": "Deployment has not matched the expected number of replicas."
                        },
                        "expr": "(\n  kube_deployment_spec_replicas{job=\"kube-state-metrics\"}\n    !=\n  kube_deployment_status_replicas_available{job=\"kube-state-metrics\"}\n) and (\n  changes(kube_deployment_status_replicas_updated{job=\"kube-state-metrics\"}[5m])\n    ==\n  0\n)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeStatefulSetReplicasMismatch",
                        "annotations": {
                            "description": "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} has not matched the expected number of replicas for longer than 15 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubestatefulsetreplicasmismatch",
                            "summary": "Deployment has not matched the expected number of replicas."
                        },
                        "expr": "(\n  kube_statefulset_status_replicas_ready{job=\"kube-state-metrics\"}\n    !=\n  kube_statefulset_status_replicas{job=\"kube-state-metrics\"}\n) and (\n  changes(kube_statefulset_status_replicas_updated{job=\"kube-state-metrics\"}[5m])\n    ==\n  0\n)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeStatefulSetGenerationMismatch",
                        "annotations": {
                            "description": "StatefulSet generation for {{ $labels.namespace }}/{{ $labels.statefulset }} does not match, this indicates that the StatefulSet has failed but has not been rolled back.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubestatefulsetgenerationmismatch",
                            "summary": "StatefulSet generation mismatch due to possible roll-back"
                        },
                        "expr": "kube_statefulset_status_observed_generation{job=\"kube-state-metrics\"}\n  !=\nkube_statefulset_metadata_generation{job=\"kube-state-metrics\"}\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeStatefulSetUpdateNotRolledOut",
                        "annotations": {
                            "description": "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} update has not been rolled out.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubestatefulsetupdatenotrolledout",
                            "summary": "StatefulSet update has not been rolled out."
                        },
                        "expr": "(\n  max without (revision) (\n    kube_statefulset_status_current_revision{job=\"kube-state-metrics\"}\n      unless\n    kube_statefulset_status_update_revision{job=\"kube-state-metrics\"}\n  )\n    *\n  (\n    kube_statefulset_replicas{job=\"kube-state-metrics\"}\n      !=\n    kube_statefulset_status_replicas_updated{job=\"kube-state-metrics\"}\n  )\n)  and (\n  changes(kube_statefulset_status_replicas_updated{job=\"kube-state-metrics\"}[5m])\n    ==\n  0\n)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeDaemonSetRolloutStuck",
                        "annotations": {
                            "description": "DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} has not finished or progressed for at least 15 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubedaemonsetrolloutstuck",
                            "summary": "DaemonSet rollout is stuck."
                        },
                        "expr": "(\n  (\n    kube_daemonset_status_current_number_scheduled{job=\"kube-state-metrics\"}\n     !=\n    kube_daemonset_status_desired_number_scheduled{job=\"kube-state-metrics\"}\n  ) or (\n    kube_daemonset_status_number_misscheduled{job=\"kube-state-metrics\"}\n     !=\n    0\n  ) or (\n    kube_daemonset_updated_number_scheduled{job=\"kube-state-metrics\"}\n     !=\n    kube_daemonset_status_desired_number_scheduled{job=\"kube-state-metrics\"}\n  ) or (\n    kube_daemonset_status_number_available{job=\"kube-state-metrics\"}\n     !=\n    kube_daemonset_status_desired_number_scheduled{job=\"kube-state-metrics\"}\n  )\n) and (\n  changes(kube_daemonset_updated_number_scheduled{job=\"kube-state-metrics\"}[5m])\n    ==\n  0\n)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeContainerWaiting",
                        "annotations": {
                            "description": "Pod {{ $labels.namespace }}/{{ $labels.pod }} container {{ $labels.container}} has been in waiting state for longer than 1 hour.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubecontainerwaiting",
                            "summary": "Pod container waiting longer than 1 hour"
                        },
                        "expr": "sum by (namespace, pod, container) (kube_pod_container_status_waiting_reason{job=\"kube-state-metrics\"}) > 0\n",
                        "for": "1h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeDaemonSetNotScheduled",
                        "annotations": {
                            "description": "{{ $value }} Pods of DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} are not scheduled.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubedaemonsetnotscheduled",
                            "summary": "DaemonSet pods are not scheduled."
                        },
                        "expr": "kube_daemonset_status_desired_number_scheduled{job=\"kube-state-metrics\"}\n  -\nkube_daemonset_status_current_number_scheduled{job=\"kube-state-metrics\"} > 0\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeDaemonSetMisScheduled",
                        "annotations": {
                            "description": "{{ $value }} Pods of DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} are running where they are not supposed to run.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubedaemonsetmisscheduled",
                            "summary": "DaemonSet pods are misscheduled."
                        },
                        "expr": "kube_daemonset_status_number_misscheduled{job=\"kube-state-metrics\"} > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeJobCompletion",
                        "annotations": {
                            "description": "Job {{ $labels.namespace }}/{{ $labels.job_name }} is taking more than 12 hours to complete.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubejobcompletion",
                            "summary": "Job did not complete in time"
                        },
                        "expr": "kube_job_spec_completions{job=\"kube-state-metrics\"} - kube_job_status_succeeded{job=\"kube-state-metrics\"}  > 0\n",
                        "for": "12h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeJobFailed",
                        "annotations": {
                            "description": "Job {{ $labels.namespace }}/{{ $labels.job_name }} failed to complete.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubejobfailed",
                            "summary": "Job failed to complete."
                        },
                        "expr": "kube_job_failed{job=\"kube-state-metrics\"}  > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeHpaReplicasMismatch",
                        "annotations": {
                            "description": "HPA {{ $labels.namespace }}/{{ $labels.hpa }} has not matched the desired number of replicas for longer than 15 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubehpareplicasmismatch",
                            "summary": "HPA has not matched descired number of replicas."
                        },
                        "expr": "(kube_hpa_status_desired_replicas{job=\"kube-state-metrics\"}\n  !=\nkube_hpa_status_current_replicas{job=\"kube-state-metrics\"})\n  and\nchanges(kube_hpa_status_current_replicas[15m]) == 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeHpaMaxedOut",
                        "annotations": {
                            "description": "HPA {{ $labels.namespace }}/{{ $labels.hpa }} has been running at max replicas for longer than 15 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubehpamaxedout",
                            "summary": "HPA is running at max replicas"
                        },
                        "expr": "kube_hpa_status_current_replicas{job=\"kube-state-metrics\"}\n  ==\nkube_hpa_spec_max_replicas{job=\"kube-state-metrics\"}\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    }
                ]
            },
            {
                "name": "kubernetes-resources",
                "rules": [
                    {
                        "alert": "KubeCPUOvercommit",
                        "annotations": {
                            "description": "Cluster has overcommitted CPU resource requests for Pods and cannot tolerate node failure.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubecpuovercommit",
                            "summary": "Cluster has overcommitted CPU resource requests."
                        },
                        "expr": "sum(namespace:kube_pod_container_resource_requests_cpu_cores:sum{})\n  /\nsum(kube_node_status_allocatable_cpu_cores)\n  >\n(count(kube_node_status_allocatable_cpu_cores)-1) / count(kube_node_status_allocatable_cpu_cores)\n",
                        "for": "5m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeMemoryOvercommit",
                        "annotations": {
                            "description": "Cluster has overcommitted memory resource requests for Pods and cannot tolerate node failure.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubememoryovercommit",
                            "summary": "Cluster has overcommitted memory resource requests."
                        },
                        "expr": "sum(namespace:kube_pod_container_resource_requests_memory_bytes:sum{})\n  /\nsum(kube_node_status_allocatable_memory_bytes)\n  >\n(count(kube_node_status_allocatable_memory_bytes)-1)\n  /\ncount(kube_node_status_allocatable_memory_bytes)\n",
                        "for": "5m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeCPUQuotaOvercommit",
                        "annotations": {
                            "description": "Cluster has overcommitted CPU resource requests for Namespaces.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubecpuquotaovercommit",
                            "summary": "Cluster has overcommitted CPU resource requests."
                        },
                        "expr": "sum(kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\", resource=\"cpu\"})\n  /\nsum(kube_node_status_allocatable_cpu_cores)\n  > 1.5\n",
                        "for": "5m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeMemoryQuotaOvercommit",
                        "annotations": {
                            "description": "Cluster has overcommitted memory resource requests for Namespaces.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubememoryquotaovercommit",
                            "summary": "Cluster has overcommitted memory resource requests."
                        },
                        "expr": "sum(kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\", resource=\"memory\"})\n  /\nsum(kube_node_status_allocatable_memory_bytes{job=\"node-exporter\"})\n  > 1.5\n",
                        "for": "5m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeQuotaAlmostFull",
                        "annotations": {
                            "description": "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubequotaalmostfull",
                            "summary": "Namespace quota is going to be full."
                        },
                        "expr": "kube_resourcequota{job=\"kube-state-metrics\", type=\"used\"}\n  / ignoring(instance, job, type)\n(kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\"} > 0)\n  > 0.9 < 1\n",
                        "for": "15m",
                        "labels": {
                            "severity": "info"
                        }
                    },
                    {
                        "alert": "KubeQuotaFullyUsed",
                        "annotations": {
                            "description": "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubequotafullyused",
                            "summary": "Namespace quota is fully used."
                        },
                        "expr": "kube_resourcequota{job=\"kube-state-metrics\", type=\"used\"}\n  / ignoring(instance, job, type)\n(kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\"} > 0)\n  == 1\n",
                        "for": "15m",
                        "labels": {
                            "severity": "info"
                        }
                    },
                    {
                        "alert": "KubeQuotaExceeded",
                        "annotations": {
                            "description": "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubequotaexceeded",
                            "summary": "Namespace quota has exceeded the limits."
                        },
                        "expr": "kube_resourcequota{job=\"kube-state-metrics\", type=\"used\"}\n  / ignoring(instance, job, type)\n(kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\"} > 0)\n  > 1\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "CPUThrottlingHigh",
                        "annotations": {
                            "description": "{{ $value | humanizePercentage }} throttling of CPU in namespace {{ $labels.namespace }} for container {{ $labels.container }} in pod {{ $labels.pod }}.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-cputhrottlinghigh",
                            "summary": "Processes experience elevated CPU throttling."
                        },
                        "expr": "sum(increase(container_cpu_cfs_throttled_periods_total{container!=\"\", }[5m])) by (container, pod, namespace)\n  /\nsum(increase(container_cpu_cfs_periods_total{}[5m])) by (container, pod, namespace)\n  > ( 25 / 100 )\n",
                        "for": "15m",
                        "labels": {
                            "severity": "info"
                        }
                    }
                ]
            },
            {
                "name": "kubernetes-storage",
                "rules": [
                    {
                        "alert": "KubePersistentVolumeFillingUp",
                        "annotations": {
                            "description": "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} is only {{ $value | humanizePercentage }} free.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubepersistentvolumefillingup",
                            "summary": "PersistentVolume is filling up."
                        },
                        "expr": "kubelet_volume_stats_available_bytes{job=\"kubelet\", metrics_path=\"/metrics\"}\n  /\nkubelet_volume_stats_capacity_bytes{job=\"kubelet\", metrics_path=\"/metrics\"}\n  < 0.03\n",
                        "for": "1m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "KubePersistentVolumeFillingUp",
                        "annotations": {
                            "description": "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} is expected to fill up within four days. Currently {{ $value | humanizePercentage }} is available.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubepersistentvolumefillingup",
                            "summary": "PersistentVolume is filling up."
                        },
                        "expr": "(\n  kubelet_volume_stats_available_bytes{job=\"kubelet\", metrics_path=\"/metrics\"}\n    /\n  kubelet_volume_stats_capacity_bytes{job=\"kubelet\", metrics_path=\"/metrics\"}\n) < 0.15\nand\npredict_linear(kubelet_volume_stats_available_bytes{job=\"kubelet\", metrics_path=\"/metrics\"}[6h], 4 * 24 * 3600) < 0\n",
                        "for": "1h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubePersistentVolumeErrors",
                        "annotations": {
                            "description": "The persistent volume {{ $labels.persistentvolume }} has status {{ $labels.phase }}.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubepersistentvolumeerrors",
                            "summary": "PersistentVolume is having issues with provisioning."
                        },
                        "expr": "kube_persistentvolume_status_phase{phase=~\"Failed|Pending\",job=\"kube-state-metrics\"} > 0\n",
                        "for": "5m",
                        "labels": {
                            "severity": "critical"
                        }
                    }
                ]
            },
            {
                "name": "kubernetes-system",
                "rules": [
                    {
                        "alert": "KubeVersionMismatch",
                        "annotations": {
                            "description": "There are {{ $value }} different semantic versions of Kubernetes components running.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeversionmismatch",
                            "summary": "Different semantic versions of Kubernetes components running."
                        },
                        "expr": "count(count by (gitVersion) (label_replace(kubernetes_build_info{job!~\"kube-dns|coredns\"},\"gitVersion\",\"$1\",\"gitVersion\",\"(v[0-9]*.[0-9]*).*\"))) > 1\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeClientErrors",
                        "annotations": {
                            "description": "Kubernetes API server client '{{ $labels.job }}/{{ $labels.instance }}' is experiencing {{ $value | humanizePercentage }} errors.'",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeclienterrors",
                            "summary": "Kubernetes API server client is experiencing errors."
                        },
                        "expr": "(sum(rate(rest_client_requests_total{code=~\"5..\"}[5m])) by (instance, job)\n  /\nsum(rate(rest_client_requests_total[5m])) by (instance, job))\n> 0.01\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    }
                ]
            },
            {
                "name": "kube-apiserver-slos",
                "rules": [
                    {
                        "alert": "KubeAPIErrorBudgetBurn",
                        "annotations": {
                            "description": "The API server is burning too much error budget.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeapierrorbudgetburn",
                            "summary": "The API server is burning too much error budget."
                        },
                        "expr": "sum(apiserver_request:burnrate1h) > (14.40 * 0.01000)\nand\nsum(apiserver_request:burnrate5m) > (14.40 * 0.01000)\n",
                        "for": "2m",
                        "labels": {
                            "long": "1h",
                            "severity": "critical",
                            "short": "5m"
                        }
                    },
                    {
                        "alert": "KubeAPIErrorBudgetBurn",
                        "annotations": {
                            "description": "The API server is burning too much error budget.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeapierrorbudgetburn",
                            "summary": "The API server is burning too much error budget."
                        },
                        "expr": "sum(apiserver_request:burnrate6h) > (6.00 * 0.01000)\nand\nsum(apiserver_request:burnrate30m) > (6.00 * 0.01000)\n",
                        "for": "15m",
                        "labels": {
                            "long": "6h",
                            "severity": "critical",
                            "short": "30m"
                        }
                    },
                    {
                        "alert": "KubeAPIErrorBudgetBurn",
                        "annotations": {
                            "description": "The API server is burning too much error budget.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeapierrorbudgetburn",
                            "summary": "The API server is burning too much error budget."
                        },
                        "expr": "sum(apiserver_request:burnrate1d) > (3.00 * 0.01000)\nand\nsum(apiserver_request:burnrate2h) > (3.00 * 0.01000)\n",
                        "for": "1h",
                        "labels": {
                            "long": "1d",
                            "severity": "warning",
                            "short": "2h"
                        }
                    },
                    {
                        "alert": "KubeAPIErrorBudgetBurn",
                        "annotations": {
                            "description": "The API server is burning too much error budget.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeapierrorbudgetburn",
                            "summary": "The API server is burning too much error budget."
                        },
                        "expr": "sum(apiserver_request:burnrate3d) > (1.00 * 0.01000)\nand\nsum(apiserver_request:burnrate6h) > (1.00 * 0.01000)\n",
                        "for": "3h",
                        "labels": {
                            "long": "3d",
                            "severity": "warning",
                            "short": "6h"
                        }
                    }
                ]
            },
            {
                "name": "kubernetes-system-apiserver",
                "rules": [
                    {
                        "alert": "KubeClientCertificateExpiration",
                        "annotations": {
                            "description": "A client certificate used to authenticate to the apiserver is expiring in less than 7.0 days.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeclientcertificateexpiration",
                            "summary": "Client certificate is about to expire."
                        },
                        "expr": "apiserver_client_certificate_expiration_seconds_count{job=\"apiserver\"} > 0 and on(job) histogram_quantile(0.01, sum by (job, le) (rate(apiserver_client_certificate_expiration_seconds_bucket{job=\"apiserver\"}[5m]))) < 604800\n",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeClientCertificateExpiration",
                        "annotations": {
                            "description": "A client certificate used to authenticate to the apiserver is expiring in less than 24.0 hours.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeclientcertificateexpiration",
                            "summary": "Client certificate is about to expire."
                        },
                        "expr": "apiserver_client_certificate_expiration_seconds_count{job=\"apiserver\"} > 0 and on(job) histogram_quantile(0.01, sum by (job, le) (rate(apiserver_client_certificate_expiration_seconds_bucket{job=\"apiserver\"}[5m]))) < 86400\n",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "AggregatedAPIErrors",
                        "annotations": {
                            "description": "An aggregated API {{ $labels.name }}/{{ $labels.namespace }} has reported errors. The number of errors have increased for it in the past five minutes. High values indicate that the availability of the service changes too often.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-aggregatedapierrors",
                            "summary": "An aggregated API has reported errors."
                        },
                        "expr": "sum by(name, namespace)(increase(aggregator_unavailable_apiservice_count[5m])) > 2\n",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "AggregatedAPIDown",
                        "annotations": {
                            "description": "An aggregated API {{ $labels.name }}/{{ $labels.namespace }} has been only {{ $value | humanize }}% available over the last 10m.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-aggregatedapidown",
                            "summary": "An aggregated API is down."
                        },
                        "expr": "(1 - max by(name, namespace)(avg_over_time(aggregator_unavailable_apiservice[10m]))) * 100 < 85\n",
                        "for": "5m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeAPIDown",
                        "annotations": {
                            "description": "KubeAPI has disappeared from Prometheus target discovery.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeapidown",
                            "summary": "Target disappeared from Prometheus target discovery."
                        },
                        "expr": "absent(up{job=\"apiserver\"} == 1)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    }
                ]
            },
            {
                "name": "kubernetes-system-kubelet",
                "rules": [
                    {
                        "alert": "KubeNodeNotReady",
                        "annotations": {
                            "description": "{{ $labels.node }} has been unready for more than 15 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubenodenotready",
                            "summary": "Node is not ready."
                        },
                        "expr": "kube_node_status_condition{job=\"kube-state-metrics\",condition=\"Ready\",status=\"true\"} == 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeNodeUnreachable",
                        "annotations": {
                            "description": "{{ $labels.node }} is unreachable and some workloads may be rescheduled.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubenodeunreachable",
                            "summary": "Node is unreachable."
                        },
                        "expr": "(kube_node_spec_taint{job=\"kube-state-metrics\",key=\"node.kubernetes.io/unreachable\",effect=\"NoSchedule\"} unless ignoring(key,value) kube_node_spec_taint{job=\"kube-state-metrics\",key=~\"ToBeDeletedByClusterAutoscaler|cloud.google.com/impending-node-termination|aws-node-termination-handler/spot-itn\"}) == 1\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeletTooManyPods",
                        "annotations": {
                            "description": "Kubelet '{{ $labels.node }}' is running at {{ $value | humanizePercentage }} of its Pod capacity.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubelettoomanypods",
                            "summary": "Kubelet is running at capacity."
                        },
                        "expr": "count by(node) (\n  (kube_pod_status_phase{job=\"kube-state-metrics\",phase=\"Running\"} == 1) * on(instance,pod,namespace,cluster) group_left(node) topk by(instance,pod,namespace,cluster) (1, kube_pod_info{job=\"kube-state-metrics\"})\n)\n/\nmax by(node) (\n  kube_node_status_capacity_pods{job=\"kube-state-metrics\"} != 1\n) > 0.95\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeNodeReadinessFlapping",
                        "annotations": {
                            "description": "The readiness status of node {{ $labels.node }} has changed {{ $value }} times in the last 15 minutes.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubenodereadinessflapping",
                            "summary": "Node readiness status is flapping."
                        },
                        "expr": "sum(changes(kube_node_status_condition{status=\"true\",condition=\"Ready\"}[15m])) by (node) > 2\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeletPlegDurationHigh",
                        "annotations": {
                            "description": "The Kubelet Pod Lifecycle Event Generator has a 99th percentile duration of {{ $value }} seconds on node {{ $labels.node }}.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletplegdurationhigh",
                            "summary": "Kubelet Pod Lifecycle Event Generator is taking too long to relist."
                        },
                        "expr": "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile{quantile=\"0.99\"} >= 10\n",
                        "for": "5m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeletPodStartUpLatencyHigh",
                        "annotations": {
                            "description": "Kubelet Pod startup 99th percentile latency is {{ $value }} seconds on node {{ $labels.node }}.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletpodstartuplatencyhigh",
                            "summary": "Kubelet Pod startup latency is too high."
                        },
                        "expr": "histogram_quantile(0.99, sum(rate(kubelet_pod_worker_duration_seconds_bucket{job=\"kubelet\", metrics_path=\"/metrics\"}[5m])) by (instance, le)) * on(instance) group_left(node) kubelet_node_name{job=\"kubelet\", metrics_path=\"/metrics\"} > 60\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeletClientCertificateExpiration",
                        "annotations": {
                            "description": "Client certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletclientcertificateexpiration",
                            "summary": "Kubelet client certificate is about to expire."
                        },
                        "expr": "kubelet_certificate_manager_client_ttl_seconds < 604800\n",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeletClientCertificateExpiration",
                        "annotations": {
                            "description": "Client certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletclientcertificateexpiration",
                            "summary": "Kubelet client certificate is about to expire."
                        },
                        "expr": "kubelet_certificate_manager_client_ttl_seconds < 86400\n",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "KubeletServerCertificateExpiration",
                        "annotations": {
                            "description": "Server certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletservercertificateexpiration",
                            "summary": "Kubelet server certificate is about to expire."
                        },
                        "expr": "kubelet_certificate_manager_server_ttl_seconds < 604800\n",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeletServerCertificateExpiration",
                        "annotations": {
                            "description": "Server certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletservercertificateexpiration",
                            "summary": "Kubelet server certificate is about to expire."
                        },
                        "expr": "kubelet_certificate_manager_server_ttl_seconds < 86400\n",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "KubeletClientCertificateRenewalErrors",
                        "annotations": {
                            "description": "Kubelet on node {{ $labels.node }} has failed to renew its client certificate ({{ $value | humanize }} errors in the last 5 minutes).",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletclientcertificaterenewalerrors",
                            "summary": "Kubelet has failed to renew its client certificate."
                        },
                        "expr": "increase(kubelet_certificate_manager_client_expiration_renew_errors[5m]) > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeletServerCertificateRenewalErrors",
                        "annotations": {
                            "description": "Kubelet on node {{ $labels.node }} has failed to renew its server certificate ({{ $value | humanize }} errors in the last 5 minutes).",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletservercertificaterenewalerrors",
                            "summary": "Kubelet has failed to renew its server certificate."
                        },
                        "expr": "increase(kubelet_server_expiration_renew_errors[5m]) > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "KubeletDown",
                        "annotations": {
                            "description": "Kubelet has disappeared from Prometheus target discovery.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeletdown",
                            "summary": "Target disappeared from Prometheus target discovery."
                        },
                        "expr": "absent(up{job=\"kubelet\", metrics_path=\"/metrics\"} == 1)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    }
                ]
            },
            {
                "name": "kubernetes-system-scheduler",
                "rules": [
                    {
                        "alert": "KubeSchedulerDown",
                        "annotations": {
                            "description": "KubeScheduler has disappeared from Prometheus target discovery.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubeschedulerdown",
                            "summary": "Target disappeared from Prometheus target discovery."
                        },
                        "expr": "absent(up{job=\"kube-scheduler\"} == 1)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    }
                ]
            },
            {
                "name": "kubernetes-system-controller-manager",
                "rules": [
                    {
                        "alert": "KubeControllerManagerDown",
                        "annotations": {
                            "description": "KubeControllerManager has disappeared from Prometheus target discovery.",
                            "runbook_url": "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-kubecontrollermanagerdown",
                            "summary": "Target disappeared from Prometheus target discovery."
                        },
                        "expr": "absent(up{job=\"kube-controller-manager\"} == 1)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    }
                ]
            },
            {
                "name": "prometheus",
                "rules": [
                    {
                        "alert": "PrometheusBadConfig",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} has failed to reload its configuration.",
                            "summary": "Failed Prometheus configuration reload."
                        },
                        "expr": "# Without max_over_time, failed scrapes could create false negatives, see\n# https://www.robustperception.io/alerting-on-gauges-in-prometheus-2-0 for details.\nmax_over_time(prometheus_config_last_reload_successful{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m]) == 0\n",
                        "for": "10m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "PrometheusNotificationQueueRunningFull",
                        "annotations": {
                            "description": "Alert notification queue of Prometheus {{$labels.namespace}}/{{$labels.pod}} is running full.",
                            "summary": "Prometheus alert notification queue predicted to run full in less than 30m."
                        },
                        "expr": "# Without min_over_time, failed scrapes could create false negatives, see\n# https://www.robustperception.io/alerting-on-gauges-in-prometheus-2-0 for details.\n(\n  predict_linear(prometheus_notifications_queue_length{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m], 60 * 30)\n>\n  min_over_time(prometheus_notifications_queue_capacity{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusErrorSendingAlertsToSomeAlertmanagers",
                        "annotations": {
                            "description": "{{ printf \"%.1f\" $value }}% errors while sending alerts from Prometheus {{$labels.namespace}}/{{$labels.pod}} to Alertmanager {{$labels.alertmanager}}.",
                            "summary": "Prometheus has encountered more than 1% errors sending alerts to a specific Alertmanager."
                        },
                        "expr": "(\n  rate(prometheus_notifications_errors_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n/\n  rate(prometheus_notifications_sent_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n)\n* 100\n> 1\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusErrorSendingAlertsToAnyAlertmanager",
                        "annotations": {
                            "description": "{{ printf \"%.1f\" $value }}% minimum errors while sending alerts from Prometheus {{$labels.namespace}}/{{$labels.pod}} to any Alertmanager.",
                            "summary": "Prometheus encounters more than 3% errors sending alerts to any Alertmanager."
                        },
                        "expr": "min without(alertmanager) (\n  rate(prometheus_notifications_errors_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n/\n  rate(prometheus_notifications_sent_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n)\n* 100\n> 3\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "PrometheusNotConnectedToAlertmanagers",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} is not connected to any Alertmanagers.",
                            "summary": "Prometheus is not connected to any Alertmanagers."
                        },
                        "expr": "# Without max_over_time, failed scrapes could create false negatives, see\n# https://www.robustperception.io/alerting-on-gauges-in-prometheus-2-0 for details.\nmax_over_time(prometheus_notifications_alertmanagers_discovered{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m]) < 1\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusTSDBReloadsFailing",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} has detected {{$value | humanize}} reload failures over the last 3h.",
                            "summary": "Prometheus has issues reloading blocks from disk."
                        },
                        "expr": "increase(prometheus_tsdb_reloads_failures_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[3h]) > 0\n",
                        "for": "4h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusTSDBCompactionsFailing",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} has detected {{$value | humanize}} compaction failures over the last 3h.",
                            "summary": "Prometheus has issues compacting blocks."
                        },
                        "expr": "increase(prometheus_tsdb_compactions_failed_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[3h]) > 0\n",
                        "for": "4h",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusNotIngestingSamples",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} is not ingesting samples.",
                            "summary": "Prometheus is not ingesting samples."
                        },
                        "expr": "rate(prometheus_tsdb_head_samples_appended_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m]) <= 0\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusDuplicateTimestamps",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} is dropping {{ printf \"%.4g\" $value  }} samples/s with different values but duplicated timestamp.",
                            "summary": "Prometheus is dropping samples with duplicate timestamps."
                        },
                        "expr": "rate(prometheus_target_scrapes_sample_duplicate_timestamp_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m]) > 0\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusOutOfOrderTimestamps",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} is dropping {{ printf \"%.4g\" $value  }} samples/s with timestamps arriving out of order.",
                            "summary": "Prometheus drops samples with out-of-order timestamps."
                        },
                        "expr": "rate(prometheus_target_scrapes_sample_out_of_order_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m]) > 0\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusRemoteStorageFailures",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} failed to send {{ printf \"%.1f\" $value }}% of the samples to {{ $labels.remote_name}}:{{ $labels.url }}",
                            "summary": "Prometheus fails to send samples to remote storage."
                        },
                        "expr": "(\n  rate(prometheus_remote_storage_failed_samples_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n/\n  (\n    rate(prometheus_remote_storage_failed_samples_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n  +\n    rate(prometheus_remote_storage_succeeded_samples_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n  )\n)\n* 100\n> 1\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "PrometheusRemoteWriteBehind",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} remote write is {{ printf \"%.1f\" $value }}s behind for {{ $labels.remote_name}}:{{ $labels.url }}.",
                            "summary": "Prometheus remote write is behind."
                        },
                        "expr": "# Without max_over_time, failed scrapes could create false negatives, see\n# https://www.robustperception.io/alerting-on-gauges-in-prometheus-2-0 for details.\n(\n  max_over_time(prometheus_remote_storage_highest_timestamp_in_seconds{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n- on(job, instance) group_right\n  max_over_time(prometheus_remote_storage_queue_highest_sent_timestamp_seconds{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n)\n> 120\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "PrometheusRemoteWriteDesiredShards",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} remote write desired shards calculation wants to run {{ $value }} shards for queue {{ $labels.remote_name}}:{{ $labels.url }}, which is more than the max of {{ printf `prometheus_remote_storage_shards_max{instance=\"%s\",job=\"prometheus-k8s\",namespace=\"monitoring\"}` $labels.instance | query | first | value }}.",
                            "summary": "Prometheus remote write desired shards calculation wants to run more than configured max shards."
                        },
                        "expr": "# Without max_over_time, failed scrapes could create false negatives, see\n# https://www.robustperception.io/alerting-on-gauges-in-prometheus-2-0 for details.\n(\n  max_over_time(prometheus_remote_storage_shards_desired{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n>\n  max_over_time(prometheus_remote_storage_shards_max{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m])\n)\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusRuleFailures",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} has failed to evaluate {{ printf \"%.0f\" $value }} rules in the last 5m.",
                            "summary": "Prometheus is failing rule evaluations."
                        },
                        "expr": "increase(prometheus_rule_evaluation_failures_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m]) > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "PrometheusMissingRuleEvaluations",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} has missed {{ printf \"%.0f\" $value }} rule group evaluations in the last 5m.",
                            "summary": "Prometheus is missing rule evaluations due to slow rule group evaluation."
                        },
                        "expr": "increase(prometheus_rule_group_iterations_missed_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m]) > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "PrometheusTargetLimitHit",
                        "annotations": {
                            "description": "Prometheus {{$labels.namespace}}/{{$labels.pod}} has dropped {{ printf \"%.0f\" $value }} targets because the number of targets exceeded the configured target_limit.",
                            "summary": "Prometheus has dropped targets because some scrape configs have exceeded the targets limit."
                        },
                        "expr": "increase(prometheus_target_scrape_pool_exceeded_target_limit_total{job=\"prometheus-k8s\",namespace=\"monitoring\"}[5m]) > 0\n",
                        "for": "15m",
                        "labels": {
                            "severity": "warning"
                        }
                    }
                ]
            },
            {
                "name": "alertmanager.rules",
                "rules": [
                    {
                        "alert": "AlertmanagerConfigInconsistent",
                        "annotations": {
                            "message": "The configuration of the instances of the Alertmanager cluster `{{ $labels.namespace }}/{{ $labels.service }}` are out of sync.\n{{ range printf \"alertmanager_config_hash{namespace=\\\"%s\\\",service=\\\"%s\\\"}\" $labels.namespace $labels.service | query }}\nConfiguration hash for pod {{ .Labels.pod }} is \"{{ printf \"%.f\" .Value }}\"\n{{ end }}\n"
                        },
                        "expr": "count by(namespace,service) (count_values by(namespace,service) (\"config_hash\", alertmanager_config_hash{job=\"alertmanager-main\",namespace=\"monitoring\"})) != 1\n",
                        "for": "5m",
                        "labels": {
                            "severity": "critical"
                        }
                    },
                    {
                        "alert": "AlertmanagerFailedReload",
                        "annotations": {
                            "message": "Reloading Alertmanager's configuration has failed for {{ $labels.namespace }}/{{ $labels.pod}}."
                        },
                        "expr": "alertmanager_config_last_reload_successful{job=\"alertmanager-main\",namespace=\"monitoring\"} == 0\n",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "AlertmanagerMembersInconsistent",
                        "annotations": {
                            "message": "Alertmanager has not found all other members of the cluster."
                        },
                        "expr": "alertmanager_cluster_members{job=\"alertmanager-main\",namespace=\"monitoring\"}\n  != on (service) GROUP_LEFT()\ncount by (service) (alertmanager_cluster_members{job=\"alertmanager-main\",namespace=\"monitoring\"})\n",
                        "for": "5m",
                        "labels": {
                            "severity": "critical"
                        }
                    }
                ]
            },
            {
                "name": "general.rules",
                "rules": [
                    {
                        "alert": "TargetDown",
                        "annotations": {
                            "message": "{{ printf \"%.4g\" $value }}% of the {{ $labels.job }}/{{ $labels.service }} targets in {{ $labels.namespace }} namespace are down."
                        },
                        "expr": "100 * (count(up == 0) BY (job, namespace, service) / count(up) BY (job, namespace, service)) > 10",
                        "for": "10m",
                        "labels": {
                            "severity": "warning"
                        }
                    },
                    {
                        "alert": "Watchdog",
                        "annotations": {
                            "message": "This is an alert meant to ensure that the entire alerting pipeline is functional.\nThis alert is always firing, therefore it should always be firing in Alertmanager\nand always fire against a receiver. There are integrations with various notification\nmechanisms that send a notification when this alert is not firing. For example the\n\"DeadMansSnitch\" integration in PagerDuty.\n"
                        },
                        "expr": "vector(1)",
                        "labels": {
                            "severity": "none"
                        }
                    }
                ]
            },
            {
                "name": "node-network",
                "rules": [
                    {
                        "alert": "NodeNetworkInterfaceFlapping",
                        "annotations": {
                            "message": "Network interface \"{{ $labels.device }}\" changing it's up status often on node-exporter {{ $labels.namespace }}/{{ $labels.pod }}\""
                        },
                        "expr": "changes(node_network_up{job=\"node-exporter\",device!~\"veth.+\"}[2m]) > 2\n",
                        "for": "2m",
                        "labels": {
                            "severity": "warning"
                        }
                    }
                ]
            }
        ]
    }
}

}
