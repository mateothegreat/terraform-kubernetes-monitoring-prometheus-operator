variable "operator_namespace" {

    type        = string
    description = "namespace to install operator in"

}

variable "grafana_enabled" {

    type        = bool
    description = "install grafana"
    default     = false

}

variable "alertmanager_enabled" {

    type        = bool
    description = "install alertmanager"
    default     = false

}

variable "alertmanager_replicas" {

    type        = number
    description = "number of alertmanager replicas"
    default     = 1

}

variable "alertmanager_node_selector" {

    type        = map(string)
    description = "restrict alertmanager pods to run on this specification"
    default     = {}

}
