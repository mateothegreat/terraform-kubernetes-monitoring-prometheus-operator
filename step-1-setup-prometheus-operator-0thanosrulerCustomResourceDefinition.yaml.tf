resource "kubernetes_manifest" "thanosrulers_monitoring_coreos_com" {

    provider = kubernetes-alpha

    manifest = {
    "apiVersion": "apiextensions.k8s.io/v1",
    "kind": "CustomResourceDefinition",
    "metadata": {
        "annotations": {
            "controller-gen.kubebuilder.io/version": "v0.2.4"
        },
        "creationTimestamp": null,
        "name": "thanosrulers.monitoring.coreos.com"
    },
    "spec": {
        "group": "monitoring.coreos.com",
        "names": {
            "kind": "ThanosRuler",
            "listKind": "ThanosRulerList",
            "plural": "thanosrulers",
            "singular": "thanosruler"
        },
        "scope": "Namespaced",
        "versions": [
            {
                "name": "v1",
                "schema": {
                    "openAPIV3Schema": {
                        "description": "ThanosRuler defines a ThanosRuler deployment.",
                        "properties": {
                            "apiVersion": {
                                "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
                                "type": "string"
                            },
                            "kind": {
                                "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
                                "type": "string"
                            },
                            "metadata": {
                                "type": "object"
                            },
                            "spec": {
                                "description": "Specification of the desired behavior of the ThanosRuler cluster. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status",
                                "properties": {
                                    "affinity": {
                                        "description": "If specified, the pod's scheduling constraints.",
                                        "properties": {
                                            "nodeAffinity": {
                                                "description": "Describes node affinity scheduling rules for the pod.",
                                                "properties": {
                                                    "preferredDuringSchedulingIgnoredDuringExecution": {
                                                        "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.",
                                                        "items": {
                                                            "description": "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).",
                                                            "properties": {
                                                                "preference": {
                                                                    "description": "A node selector term, associated with the corresponding weight.",
                                                                    "properties": {
                                                                        "matchExpressions": {
                                                                            "description": "A list of node selector requirements by node's labels.",
                                                                            "items": {
                                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                                "properties": {
                                                                                    "key": {
                                                                                        "description": "The label key that the selector applies to.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "operator": {
                                                                                        "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "values": {
                                                                                        "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                                        "items": {
                                                                                            "type": "string"
                                                                                        },
                                                                                        "type": "array"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "key",
                                                                                    "operator"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "matchFields": {
                                                                            "description": "A list of node selector requirements by node's fields.",
                                                                            "items": {
                                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                                "properties": {
                                                                                    "key": {
                                                                                        "description": "The label key that the selector applies to.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "operator": {
                                                                                        "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "values": {
                                                                                        "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                                        "items": {
                                                                                            "type": "string"
                                                                                        },
                                                                                        "type": "array"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "key",
                                                                                    "operator"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        }
                                                                    },
                                                                    "type": "object"
                                                                },
                                                                "weight": {
                                                                    "description": "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.",
                                                                    "format": "int32",
                                                                    "type": "integer"
                                                                }
                                                            },
                                                            "required": [
                                                                "preference",
                                                                "weight"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "type": "array"
                                                    },
                                                    "requiredDuringSchedulingIgnoredDuringExecution": {
                                                        "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.",
                                                        "properties": {
                                                            "nodeSelectorTerms": {
                                                                "description": "Required. A list of node selector terms. The terms are ORed.",
                                                                "items": {
                                                                    "description": "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm.",
                                                                    "properties": {
                                                                        "matchExpressions": {
                                                                            "description": "A list of node selector requirements by node's labels.",
                                                                            "items": {
                                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                                "properties": {
                                                                                    "key": {
                                                                                        "description": "The label key that the selector applies to.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "operator": {
                                                                                        "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "values": {
                                                                                        "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                                        "items": {
                                                                                            "type": "string"
                                                                                        },
                                                                                        "type": "array"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "key",
                                                                                    "operator"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "matchFields": {
                                                                            "description": "A list of node selector requirements by node's fields.",
                                                                            "items": {
                                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                                "properties": {
                                                                                    "key": {
                                                                                        "description": "The label key that the selector applies to.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "operator": {
                                                                                        "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "values": {
                                                                                        "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                                        "items": {
                                                                                            "type": "string"
                                                                                        },
                                                                                        "type": "array"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "key",
                                                                                    "operator"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        }
                                                                    },
                                                                    "type": "object"
                                                                },
                                                                "type": "array"
                                                            }
                                                        },
                                                        "required": [
                                                            "nodeSelectorTerms"
                                                        ],
                                                        "type": "object"
                                                    }
                                                },
                                                "type": "object"
                                            },
                                            "podAffinity": {
                                                "description": "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).",
                                                "properties": {
                                                    "preferredDuringSchedulingIgnoredDuringExecution": {
                                                        "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                                        "items": {
                                                            "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                            "properties": {
                                                                "podAffinityTerm": {
                                                                    "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                                    "properties": {
                                                                        "labelSelector": {
                                                                            "description": "A label query over a set of resources, in this case pods.",
                                                                            "properties": {
                                                                                "matchExpressions": {
                                                                                    "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                                    "items": {
                                                                                        "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                                        "properties": {
                                                                                            "key": {
                                                                                                "description": "key is the label key that the selector applies to.",
                                                                                                "type": "string"
                                                                                            },
                                                                                            "operator": {
                                                                                                "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                                                "type": "string"
                                                                                            },
                                                                                            "values": {
                                                                                                "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                                                "items": {
                                                                                                    "type": "string"
                                                                                                },
                                                                                                "type": "array"
                                                                                            }
                                                                                        },
                                                                                        "required": [
                                                                                            "key",
                                                                                            "operator"
                                                                                        ],
                                                                                        "type": "object"
                                                                                    },
                                                                                    "type": "array"
                                                                                },
                                                                                "matchLabels": {
                                                                                    "additionalProperties": {
                                                                                        "type": "string"
                                                                                    },
                                                                                    "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                                    "type": "object"
                                                                                }
                                                                            },
                                                                            "type": "object"
                                                                        },
                                                                        "namespaces": {
                                                                            "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                                            "items": {
                                                                                "type": "string"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "topologyKey": {
                                                                            "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                                            "type": "string"
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "topologyKey"
                                                                    ],
                                                                    "type": "object"
                                                                },
                                                                "weight": {
                                                                    "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                                    "format": "int32",
                                                                    "type": "integer"
                                                                }
                                                            },
                                                            "required": [
                                                                "podAffinityTerm",
                                                                "weight"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "type": "array"
                                                    },
                                                    "requiredDuringSchedulingIgnoredDuringExecution": {
                                                        "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                                        "items": {
                                                            "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running",
                                                            "properties": {
                                                                "labelSelector": {
                                                                    "description": "A label query over a set of resources, in this case pods.",
                                                                    "properties": {
                                                                        "matchExpressions": {
                                                                            "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                            "items": {
                                                                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                                "properties": {
                                                                                    "key": {
                                                                                        "description": "key is the label key that the selector applies to.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "operator": {
                                                                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "values": {
                                                                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                                        "items": {
                                                                                            "type": "string"
                                                                                        },
                                                                                        "type": "array"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "key",
                                                                                    "operator"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "matchLabels": {
                                                                            "additionalProperties": {
                                                                                "type": "string"
                                                                            },
                                                                            "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                            "type": "object"
                                                                        }
                                                                    },
                                                                    "type": "object"
                                                                },
                                                                "namespaces": {
                                                                    "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                                    "items": {
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "topologyKey": {
                                                                    "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "required": [
                                                                "topologyKey"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "type": "array"
                                                    }
                                                },
                                                "type": "object"
                                            },
                                            "podAntiAffinity": {
                                                "description": "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).",
                                                "properties": {
                                                    "preferredDuringSchedulingIgnoredDuringExecution": {
                                                        "description": "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                                        "items": {
                                                            "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                            "properties": {
                                                                "podAffinityTerm": {
                                                                    "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                                    "properties": {
                                                                        "labelSelector": {
                                                                            "description": "A label query over a set of resources, in this case pods.",
                                                                            "properties": {
                                                                                "matchExpressions": {
                                                                                    "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                                    "items": {
                                                                                        "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                                        "properties": {
                                                                                            "key": {
                                                                                                "description": "key is the label key that the selector applies to.",
                                                                                                "type": "string"
                                                                                            },
                                                                                            "operator": {
                                                                                                "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                                                "type": "string"
                                                                                            },
                                                                                            "values": {
                                                                                                "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                                                "items": {
                                                                                                    "type": "string"
                                                                                                },
                                                                                                "type": "array"
                                                                                            }
                                                                                        },
                                                                                        "required": [
                                                                                            "key",
                                                                                            "operator"
                                                                                        ],
                                                                                        "type": "object"
                                                                                    },
                                                                                    "type": "array"
                                                                                },
                                                                                "matchLabels": {
                                                                                    "additionalProperties": {
                                                                                        "type": "string"
                                                                                    },
                                                                                    "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                                    "type": "object"
                                                                                }
                                                                            },
                                                                            "type": "object"
                                                                        },
                                                                        "namespaces": {
                                                                            "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                                            "items": {
                                                                                "type": "string"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "topologyKey": {
                                                                            "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                                            "type": "string"
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "topologyKey"
                                                                    ],
                                                                    "type": "object"
                                                                },
                                                                "weight": {
                                                                    "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                                    "format": "int32",
                                                                    "type": "integer"
                                                                }
                                                            },
                                                            "required": [
                                                                "podAffinityTerm",
                                                                "weight"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "type": "array"
                                                    },
                                                    "requiredDuringSchedulingIgnoredDuringExecution": {
                                                        "description": "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                                        "items": {
                                                            "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running",
                                                            "properties": {
                                                                "labelSelector": {
                                                                    "description": "A label query over a set of resources, in this case pods.",
                                                                    "properties": {
                                                                        "matchExpressions": {
                                                                            "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                            "items": {
                                                                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                                "properties": {
                                                                                    "key": {
                                                                                        "description": "key is the label key that the selector applies to.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "operator": {
                                                                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "values": {
                                                                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                                        "items": {
                                                                                            "type": "string"
                                                                                        },
                                                                                        "type": "array"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "key",
                                                                                    "operator"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "matchLabels": {
                                                                            "additionalProperties": {
                                                                                "type": "string"
                                                                            },
                                                                            "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                            "type": "object"
                                                                        }
                                                                    },
                                                                    "type": "object"
                                                                },
                                                                "namespaces": {
                                                                    "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                                    "items": {
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "topologyKey": {
                                                                    "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "required": [
                                                                "topologyKey"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "type": "array"
                                                    }
                                                },
                                                "type": "object"
                                            }
                                        },
                                        "type": "object"
                                    },
                                    "alertDropLabels": {
                                        "description": "AlertDropLabels configure the label names which should be dropped in ThanosRuler alerts. If `labels` field is not provided, `thanos_ruler_replica` will be dropped in alerts by default.",
                                        "items": {
                                            "type": "string"
                                        },
                                        "type": "array"
                                    },
                                    "alertQueryUrl": {
                                        "description": "The external Query URL the Thanos Ruler will set in the 'Source' field of all alerts. Maps to the '--alert.query-url' CLI arg.",
                                        "type": "string"
                                    },
                                    "alertmanagersConfig": {
                                        "description": "Define configuration for connecting to alertmanager.  Only available with thanos v0.10.0 and higher.  Maps to the `alertmanagers.config` arg.",
                                        "properties": {
                                            "key": {
                                                "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                "type": "string"
                                            },
                                            "name": {
                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                "type": "string"
                                            },
                                            "optional": {
                                                "description": "Specify whether the Secret or its key must be defined",
                                                "type": "boolean"
                                            }
                                        },
                                        "required": [
                                            "key"
                                        ],
                                        "type": "object"
                                    },
                                    "alertmanagersUrl": {
                                        "description": "Define URLs to send alerts to Alertmanager.  For Thanos v0.10.0 and higher, AlertManagersConfig should be used instead.  Note: this field will be ignored if AlertManagersConfig is specified. Maps to the `alertmanagers.url` arg.",
                                        "items": {
                                            "type": "string"
                                        },
                                        "type": "array"
                                    },
                                    "containers": {
                                        "description": "Containers allows injecting additional containers or modifying operator generated containers. This can be used to allow adding an authentication proxy to a ThanosRuler pod or to change the behavior of an operator generated container. Containers described here modify an operator generated container if they share the same name and modifications are done via a strategic merge patch. The current container names are: `thanos-ruler` and `rules-configmap-reloader`. Overriding containers is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice.",
                                        "items": {
                                            "description": "A single application container that you want to run within a pod.",
                                            "properties": {
                                                "args": {
                                                    "description": "Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell",
                                                    "items": {
                                                        "type": "string"
                                                    },
                                                    "type": "array"
                                                },
                                                "command": {
                                                    "description": "Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell",
                                                    "items": {
                                                        "type": "string"
                                                    },
                                                    "type": "array"
                                                },
                                                "env": {
                                                    "description": "List of environment variables to set in the container. Cannot be updated.",
                                                    "items": {
                                                        "description": "EnvVar represents an environment variable present in a Container.",
                                                        "properties": {
                                                            "name": {
                                                                "description": "Name of the environment variable. Must be a C_IDENTIFIER.",
                                                                "type": "string"
                                                            },
                                                            "value": {
                                                                "description": "Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\".",
                                                                "type": "string"
                                                            },
                                                            "valueFrom": {
                                                                "description": "Source for the environment variable's value. Cannot be used if value is not empty.",
                                                                "properties": {
                                                                    "configMapKeyRef": {
                                                                        "description": "Selects a key of a ConfigMap.",
                                                                        "properties": {
                                                                            "key": {
                                                                                "description": "The key to select.",
                                                                                "type": "string"
                                                                            },
                                                                            "name": {
                                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                                "type": "string"
                                                                            },
                                                                            "optional": {
                                                                                "description": "Specify whether the ConfigMap or its key must be defined",
                                                                                "type": "boolean"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "key"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "fieldRef": {
                                                                        "description": "Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.",
                                                                        "properties": {
                                                                            "apiVersion": {
                                                                                "description": "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".",
                                                                                "type": "string"
                                                                            },
                                                                            "fieldPath": {
                                                                                "description": "Path of the field to select in the specified API version.",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "fieldPath"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "resourceFieldRef": {
                                                                        "description": "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.",
                                                                        "properties": {
                                                                            "containerName": {
                                                                                "description": "Container name: required for volumes, optional for env vars",
                                                                                "type": "string"
                                                                            },
                                                                            "divisor": {
                                                                                "description": "Specifies the output format of the exposed resources, defaults to \"1\"",
                                                                                "type": "string"
                                                                            },
                                                                            "resource": {
                                                                                "description": "Required: resource to select",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "resource"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "secretKeyRef": {
                                                                        "description": "Selects a key of a secret in the pod's namespace",
                                                                        "properties": {
                                                                            "key": {
                                                                                "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                                                "type": "string"
                                                                            },
                                                                            "name": {
                                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                                "type": "string"
                                                                            },
                                                                            "optional": {
                                                                                "description": "Specify whether the Secret or its key must be defined",
                                                                                "type": "boolean"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "key"
                                                                        ],
                                                                        "type": "object"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            }
                                                        },
                                                        "required": [
                                                            "name"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "envFrom": {
                                                    "description": "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated.",
                                                    "items": {
                                                        "description": "EnvFromSource represents the source of a set of ConfigMaps",
                                                        "properties": {
                                                            "configMapRef": {
                                                                "description": "The ConfigMap to select from",
                                                                "properties": {
                                                                    "name": {
                                                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                        "type": "string"
                                                                    },
                                                                    "optional": {
                                                                        "description": "Specify whether the ConfigMap must be defined",
                                                                        "type": "boolean"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            },
                                                            "prefix": {
                                                                "description": "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER.",
                                                                "type": "string"
                                                            },
                                                            "secretRef": {
                                                                "description": "The Secret to select from",
                                                                "properties": {
                                                                    "name": {
                                                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                        "type": "string"
                                                                    },
                                                                    "optional": {
                                                                        "description": "Specify whether the Secret must be defined",
                                                                        "type": "boolean"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            }
                                                        },
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "image": {
                                                    "description": "Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets.",
                                                    "type": "string"
                                                },
                                                "imagePullPolicy": {
                                                    "description": "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images",
                                                    "type": "string"
                                                },
                                                "lifecycle": {
                                                    "description": "Actions that the management system should take in response to container lifecycle events. Cannot be updated.",
                                                    "properties": {
                                                        "postStart": {
                                                            "description": "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks",
                                                            "properties": {
                                                                "exec": {
                                                                    "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                                    "properties": {
                                                                        "command": {
                                                                            "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                            "items": {
                                                                                "type": "string"
                                                                            },
                                                                            "type": "array"
                                                                        }
                                                                    },
                                                                    "type": "object"
                                                                },
                                                                "httpGet": {
                                                                    "description": "HTTPGet specifies the http request to perform.",
                                                                    "properties": {
                                                                        "host": {
                                                                            "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                            "type": "string"
                                                                        },
                                                                        "httpHeaders": {
                                                                            "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                            "items": {
                                                                                "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                                "properties": {
                                                                                    "name": {
                                                                                        "description": "The header field name",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "value": {
                                                                                        "description": "The header field value",
                                                                                        "type": "string"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "name",
                                                                                    "value"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "path": {
                                                                            "description": "Path to access on the HTTP server.",
                                                                            "type": "string"
                                                                        },
                                                                        "port": {
                                                                            "anyOf": [
                                                                                {
                                                                                    "type": "integer"
                                                                                },
                                                                                {
                                                                                    "type": "string"
                                                                                }
                                                                            ],
                                                                            "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                            "x-kubernetes-int-or-string": true
                                                                        },
                                                                        "scheme": {
                                                                            "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                            "type": "string"
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "port"
                                                                    ],
                                                                    "type": "object"
                                                                },
                                                                "tcpSocket": {
                                                                    "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                                    "properties": {
                                                                        "host": {
                                                                            "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                            "type": "string"
                                                                        },
                                                                        "port": {
                                                                            "anyOf": [
                                                                                {
                                                                                    "type": "integer"
                                                                                },
                                                                                {
                                                                                    "type": "string"
                                                                                }
                                                                            ],
                                                                            "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                            "x-kubernetes-int-or-string": true
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "port"
                                                                    ],
                                                                    "type": "object"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "preStop": {
                                                            "description": "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The reason for termination is passed to the handler. The Pod's termination grace period countdown begins before the PreStop hooked is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period. Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks",
                                                            "properties": {
                                                                "exec": {
                                                                    "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                                    "properties": {
                                                                        "command": {
                                                                            "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                            "items": {
                                                                                "type": "string"
                                                                            },
                                                                            "type": "array"
                                                                        }
                                                                    },
                                                                    "type": "object"
                                                                },
                                                                "httpGet": {
                                                                    "description": "HTTPGet specifies the http request to perform.",
                                                                    "properties": {
                                                                        "host": {
                                                                            "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                            "type": "string"
                                                                        },
                                                                        "httpHeaders": {
                                                                            "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                            "items": {
                                                                                "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                                "properties": {
                                                                                    "name": {
                                                                                        "description": "The header field name",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "value": {
                                                                                        "description": "The header field value",
                                                                                        "type": "string"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "name",
                                                                                    "value"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "path": {
                                                                            "description": "Path to access on the HTTP server.",
                                                                            "type": "string"
                                                                        },
                                                                        "port": {
                                                                            "anyOf": [
                                                                                {
                                                                                    "type": "integer"
                                                                                },
                                                                                {
                                                                                    "type": "string"
                                                                                }
                                                                            ],
                                                                            "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                            "x-kubernetes-int-or-string": true
                                                                        },
                                                                        "scheme": {
                                                                            "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                            "type": "string"
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "port"
                                                                    ],
                                                                    "type": "object"
                                                                },
                                                                "tcpSocket": {
                                                                    "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                                    "properties": {
                                                                        "host": {
                                                                            "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                            "type": "string"
                                                                        },
                                                                        "port": {
                                                                            "anyOf": [
                                                                                {
                                                                                    "type": "integer"
                                                                                },
                                                                                {
                                                                                    "type": "string"
                                                                                }
                                                                            ],
                                                                            "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                            "x-kubernetes-int-or-string": true
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "port"
                                                                    ],
                                                                    "type": "object"
                                                                }
                                                            },
                                                            "type": "object"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "livenessProbe": {
                                                    "description": "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                    "properties": {
                                                        "exec": {
                                                            "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                            "properties": {
                                                                "command": {
                                                                    "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                    "items": {
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "failureThreshold": {
                                                            "description": "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "httpGet": {
                                                            "description": "HTTPGet specifies the http request to perform.",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                    "type": "string"
                                                                },
                                                                "httpHeaders": {
                                                                    "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                    "items": {
                                                                        "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                        "properties": {
                                                                            "name": {
                                                                                "description": "The header field name",
                                                                                "type": "string"
                                                                            },
                                                                            "value": {
                                                                                "description": "The header field value",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "name",
                                                                            "value"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "path": {
                                                                    "description": "Path to access on the HTTP server.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                },
                                                                "scheme": {
                                                                    "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "initialDelaySeconds": {
                                                            "description": "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "periodSeconds": {
                                                            "description": "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "successThreshold": {
                                                            "description": "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "tcpSocket": {
                                                            "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "timeoutSeconds": {
                                                            "description": "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "name": {
                                                    "description": "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated.",
                                                    "type": "string"
                                                },
                                                "ports": {
                                                    "description": "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated.",
                                                    "items": {
                                                        "description": "ContainerPort represents a network port in a single container.",
                                                        "properties": {
                                                            "containerPort": {
                                                                "description": "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.",
                                                                "format": "int32",
                                                                "type": "integer"
                                                            },
                                                            "hostIP": {
                                                                "description": "What host IP to bind the external port to.",
                                                                "type": "string"
                                                            },
                                                            "hostPort": {
                                                                "description": "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.",
                                                                "format": "int32",
                                                                "type": "integer"
                                                            },
                                                            "name": {
                                                                "description": "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services.",
                                                                "type": "string"
                                                            },
                                                            "protocol": {
                                                                "description": "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\".",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "required": [
                                                            "containerPort"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "readinessProbe": {
                                                    "description": "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                    "properties": {
                                                        "exec": {
                                                            "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                            "properties": {
                                                                "command": {
                                                                    "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                    "items": {
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "failureThreshold": {
                                                            "description": "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "httpGet": {
                                                            "description": "HTTPGet specifies the http request to perform.",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                    "type": "string"
                                                                },
                                                                "httpHeaders": {
                                                                    "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                    "items": {
                                                                        "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                        "properties": {
                                                                            "name": {
                                                                                "description": "The header field name",
                                                                                "type": "string"
                                                                            },
                                                                            "value": {
                                                                                "description": "The header field value",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "name",
                                                                            "value"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "path": {
                                                                    "description": "Path to access on the HTTP server.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                },
                                                                "scheme": {
                                                                    "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "initialDelaySeconds": {
                                                            "description": "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "periodSeconds": {
                                                            "description": "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "successThreshold": {
                                                            "description": "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "tcpSocket": {
                                                            "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "timeoutSeconds": {
                                                            "description": "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "resources": {
                                                    "description": "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                    "properties": {
                                                        "limits": {
                                                            "additionalProperties": {
                                                                "type": "string"
                                                            },
                                                            "description": "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                            "type": "object"
                                                        },
                                                        "requests": {
                                                            "additionalProperties": {
                                                                "type": "string"
                                                            },
                                                            "description": "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                            "type": "object"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "securityContext": {
                                                    "description": "Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/",
                                                    "properties": {
                                                        "allowPrivilegeEscalation": {
                                                            "description": "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN",
                                                            "type": "boolean"
                                                        },
                                                        "capabilities": {
                                                            "description": "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime.",
                                                            "properties": {
                                                                "add": {
                                                                    "description": "Added capabilities",
                                                                    "items": {
                                                                        "description": "Capability represent POSIX capabilities type",
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "drop": {
                                                                    "description": "Removed capabilities",
                                                                    "items": {
                                                                        "description": "Capability represent POSIX capabilities type",
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "privileged": {
                                                            "description": "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false.",
                                                            "type": "boolean"
                                                        },
                                                        "procMount": {
                                                            "description": "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled.",
                                                            "type": "string"
                                                        },
                                                        "readOnlyRootFilesystem": {
                                                            "description": "Whether this container has a read-only root filesystem. Default is false.",
                                                            "type": "boolean"
                                                        },
                                                        "runAsGroup": {
                                                            "description": "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "format": "int64",
                                                            "type": "integer"
                                                        },
                                                        "runAsNonRoot": {
                                                            "description": "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "type": "boolean"
                                                        },
                                                        "runAsUser": {
                                                            "description": "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "format": "int64",
                                                            "type": "integer"
                                                        },
                                                        "seLinuxOptions": {
                                                            "description": "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "properties": {
                                                                "level": {
                                                                    "description": "Level is SELinux level label that applies to the container.",
                                                                    "type": "string"
                                                                },
                                                                "role": {
                                                                    "description": "Role is a SELinux role label that applies to the container.",
                                                                    "type": "string"
                                                                },
                                                                "type": {
                                                                    "description": "Type is a SELinux type label that applies to the container.",
                                                                    "type": "string"
                                                                },
                                                                "user": {
                                                                    "description": "User is a SELinux user label that applies to the container.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "windowsOptions": {
                                                            "description": "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "properties": {
                                                                "gmsaCredentialSpec": {
                                                                    "description": "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.",
                                                                    "type": "string"
                                                                },
                                                                "gmsaCredentialSpecName": {
                                                                    "description": "GMSACredentialSpecName is the name of the GMSA credential spec to use.",
                                                                    "type": "string"
                                                                },
                                                                "runAsUserName": {
                                                                    "description": "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "startupProbe": {
                                                    "description": "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. This is a beta feature enabled by the StartupProbe feature flag. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                    "properties": {
                                                        "exec": {
                                                            "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                            "properties": {
                                                                "command": {
                                                                    "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                    "items": {
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "failureThreshold": {
                                                            "description": "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "httpGet": {
                                                            "description": "HTTPGet specifies the http request to perform.",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                    "type": "string"
                                                                },
                                                                "httpHeaders": {
                                                                    "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                    "items": {
                                                                        "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                        "properties": {
                                                                            "name": {
                                                                                "description": "The header field name",
                                                                                "type": "string"
                                                                            },
                                                                            "value": {
                                                                                "description": "The header field value",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "name",
                                                                            "value"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "path": {
                                                                    "description": "Path to access on the HTTP server.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                },
                                                                "scheme": {
                                                                    "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "initialDelaySeconds": {
                                                            "description": "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "periodSeconds": {
                                                            "description": "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "successThreshold": {
                                                            "description": "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "tcpSocket": {
                                                            "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "timeoutSeconds": {
                                                            "description": "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "stdin": {
                                                    "description": "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false.",
                                                    "type": "boolean"
                                                },
                                                "stdinOnce": {
                                                    "description": "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false",
                                                    "type": "boolean"
                                                },
                                                "terminationMessagePath": {
                                                    "description": "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated.",
                                                    "type": "string"
                                                },
                                                "terminationMessagePolicy": {
                                                    "description": "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated.",
                                                    "type": "string"
                                                },
                                                "tty": {
                                                    "description": "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false.",
                                                    "type": "boolean"
                                                },
                                                "volumeDevices": {
                                                    "description": "volumeDevices is the list of block devices to be used by the container.",
                                                    "items": {
                                                        "description": "volumeDevice describes a mapping of a raw block device within a container.",
                                                        "properties": {
                                                            "devicePath": {
                                                                "description": "devicePath is the path inside of the container that the device will be mapped to.",
                                                                "type": "string"
                                                            },
                                                            "name": {
                                                                "description": "name must match the name of a persistentVolumeClaim in the pod",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "required": [
                                                            "devicePath",
                                                            "name"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "volumeMounts": {
                                                    "description": "Pod volumes to mount into the container's filesystem. Cannot be updated.",
                                                    "items": {
                                                        "description": "VolumeMount describes a mounting of a Volume within a container.",
                                                        "properties": {
                                                            "mountPath": {
                                                                "description": "Path within the container at which the volume should be mounted.  Must not contain ':'.",
                                                                "type": "string"
                                                            },
                                                            "mountPropagation": {
                                                                "description": "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10.",
                                                                "type": "string"
                                                            },
                                                            "name": {
                                                                "description": "This must match the Name of a Volume.",
                                                                "type": "string"
                                                            },
                                                            "readOnly": {
                                                                "description": "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false.",
                                                                "type": "boolean"
                                                            },
                                                            "subPath": {
                                                                "description": "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root).",
                                                                "type": "string"
                                                            },
                                                            "subPathExpr": {
                                                                "description": "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive.",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "required": [
                                                            "mountPath",
                                                            "name"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "workingDir": {
                                                    "description": "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated.",
                                                    "type": "string"
                                                }
                                            },
                                            "required": [
                                                "name"
                                            ],
                                            "type": "object"
                                        },
                                        "type": "array"
                                    },
                                    "enforcedNamespaceLabel": {
                                        "description": "EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert and metric that is user created. The label value will always be the namespace of the object that is being created.",
                                        "type": "string"
                                    },
                                    "evaluationInterval": {
                                        "description": "Interval between consecutive evaluations.",
                                        "type": "string"
                                    },
                                    "externalPrefix": {
                                        "description": "The external URL the Thanos Ruler instances will be available under. This is necessary to generate correct URLs. This is necessary if Thanos Ruler is not served from root of a DNS name.",
                                        "type": "string"
                                    },
                                    "grpcServerTlsConfig": {
                                        "description": "GRPCServerTLSConfig configures the gRPC server from which Thanos Querier reads recorded rule data. Note: Currently only the CAFile, CertFile, and KeyFile fields are supported. Maps to the '--grpc-server-tls-*' CLI args.",
                                        "properties": {
                                            "ca": {
                                                "description": "Stuct containing the CA cert to use for the targets.",
                                                "properties": {
                                                    "configMap": {
                                                        "description": "ConfigMap containing data to use for the targets.",
                                                        "properties": {
                                                            "key": {
                                                                "description": "The key to select.",
                                                                "type": "string"
                                                            },
                                                            "name": {
                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                "type": "string"
                                                            },
                                                            "optional": {
                                                                "description": "Specify whether the ConfigMap or its key must be defined",
                                                                "type": "boolean"
                                                            }
                                                        },
                                                        "required": [
                                                            "key"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "secret": {
                                                        "description": "Secret containing data to use for the targets.",
                                                        "properties": {
                                                            "key": {
                                                                "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                                "type": "string"
                                                            },
                                                            "name": {
                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                "type": "string"
                                                            },
                                                            "optional": {
                                                                "description": "Specify whether the Secret or its key must be defined",
                                                                "type": "boolean"
                                                            }
                                                        },
                                                        "required": [
                                                            "key"
                                                        ],
                                                        "type": "object"
                                                    }
                                                },
                                                "type": "object"
                                            },
                                            "caFile": {
                                                "description": "Path to the CA cert in the Prometheus container to use for the targets.",
                                                "type": "string"
                                            },
                                            "cert": {
                                                "description": "Struct containing the client cert file for the targets.",
                                                "properties": {
                                                    "configMap": {
                                                        "description": "ConfigMap containing data to use for the targets.",
                                                        "properties": {
                                                            "key": {
                                                                "description": "The key to select.",
                                                                "type": "string"
                                                            },
                                                            "name": {
                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                "type": "string"
                                                            },
                                                            "optional": {
                                                                "description": "Specify whether the ConfigMap or its key must be defined",
                                                                "type": "boolean"
                                                            }
                                                        },
                                                        "required": [
                                                            "key"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "secret": {
                                                        "description": "Secret containing data to use for the targets.",
                                                        "properties": {
                                                            "key": {
                                                                "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                                "type": "string"
                                                            },
                                                            "name": {
                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                "type": "string"
                                                            },
                                                            "optional": {
                                                                "description": "Specify whether the Secret or its key must be defined",
                                                                "type": "boolean"
                                                            }
                                                        },
                                                        "required": [
                                                            "key"
                                                        ],
                                                        "type": "object"
                                                    }
                                                },
                                                "type": "object"
                                            },
                                            "certFile": {
                                                "description": "Path to the client cert file in the Prometheus container for the targets.",
                                                "type": "string"
                                            },
                                            "insecureSkipVerify": {
                                                "description": "Disable target certificate validation.",
                                                "type": "boolean"
                                            },
                                            "keyFile": {
                                                "description": "Path to the client key file in the Prometheus container for the targets.",
                                                "type": "string"
                                            },
                                            "keySecret": {
                                                "description": "Secret containing the client key file for the targets.",
                                                "properties": {
                                                    "key": {
                                                        "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                        "type": "string"
                                                    },
                                                    "name": {
                                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                        "type": "string"
                                                    },
                                                    "optional": {
                                                        "description": "Specify whether the Secret or its key must be defined",
                                                        "type": "boolean"
                                                    }
                                                },
                                                "required": [
                                                    "key"
                                                ],
                                                "type": "object"
                                            },
                                            "serverName": {
                                                "description": "Used to verify the hostname for the targets.",
                                                "type": "string"
                                            }
                                        },
                                        "type": "object"
                                    },
                                    "image": {
                                        "description": "Thanos container image URL.",
                                        "type": "string"
                                    },
                                    "imagePullSecrets": {
                                        "description": "An optional list of references to secrets in the same namespace to use for pulling thanos images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod",
                                        "items": {
                                            "description": "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace.",
                                            "properties": {
                                                "name": {
                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                    "type": "string"
                                                }
                                            },
                                            "type": "object"
                                        },
                                        "type": "array"
                                    },
                                    "initContainers": {
                                        "description": "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the ThanosRuler configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice.",
                                        "items": {
                                            "description": "A single application container that you want to run within a pod.",
                                            "properties": {
                                                "args": {
                                                    "description": "Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell",
                                                    "items": {
                                                        "type": "string"
                                                    },
                                                    "type": "array"
                                                },
                                                "command": {
                                                    "description": "Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell",
                                                    "items": {
                                                        "type": "string"
                                                    },
                                                    "type": "array"
                                                },
                                                "env": {
                                                    "description": "List of environment variables to set in the container. Cannot be updated.",
                                                    "items": {
                                                        "description": "EnvVar represents an environment variable present in a Container.",
                                                        "properties": {
                                                            "name": {
                                                                "description": "Name of the environment variable. Must be a C_IDENTIFIER.",
                                                                "type": "string"
                                                            },
                                                            "value": {
                                                                "description": "Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\".",
                                                                "type": "string"
                                                            },
                                                            "valueFrom": {
                                                                "description": "Source for the environment variable's value. Cannot be used if value is not empty.",
                                                                "properties": {
                                                                    "configMapKeyRef": {
                                                                        "description": "Selects a key of a ConfigMap.",
                                                                        "properties": {
                                                                            "key": {
                                                                                "description": "The key to select.",
                                                                                "type": "string"
                                                                            },
                                                                            "name": {
                                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                                "type": "string"
                                                                            },
                                                                            "optional": {
                                                                                "description": "Specify whether the ConfigMap or its key must be defined",
                                                                                "type": "boolean"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "key"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "fieldRef": {
                                                                        "description": "Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.",
                                                                        "properties": {
                                                                            "apiVersion": {
                                                                                "description": "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".",
                                                                                "type": "string"
                                                                            },
                                                                            "fieldPath": {
                                                                                "description": "Path of the field to select in the specified API version.",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "fieldPath"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "resourceFieldRef": {
                                                                        "description": "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.",
                                                                        "properties": {
                                                                            "containerName": {
                                                                                "description": "Container name: required for volumes, optional for env vars",
                                                                                "type": "string"
                                                                            },
                                                                            "divisor": {
                                                                                "description": "Specifies the output format of the exposed resources, defaults to \"1\"",
                                                                                "type": "string"
                                                                            },
                                                                            "resource": {
                                                                                "description": "Required: resource to select",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "resource"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "secretKeyRef": {
                                                                        "description": "Selects a key of a secret in the pod's namespace",
                                                                        "properties": {
                                                                            "key": {
                                                                                "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                                                "type": "string"
                                                                            },
                                                                            "name": {
                                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                                "type": "string"
                                                                            },
                                                                            "optional": {
                                                                                "description": "Specify whether the Secret or its key must be defined",
                                                                                "type": "boolean"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "key"
                                                                        ],
                                                                        "type": "object"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            }
                                                        },
                                                        "required": [
                                                            "name"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "envFrom": {
                                                    "description": "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated.",
                                                    "items": {
                                                        "description": "EnvFromSource represents the source of a set of ConfigMaps",
                                                        "properties": {
                                                            "configMapRef": {
                                                                "description": "The ConfigMap to select from",
                                                                "properties": {
                                                                    "name": {
                                                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                        "type": "string"
                                                                    },
                                                                    "optional": {
                                                                        "description": "Specify whether the ConfigMap must be defined",
                                                                        "type": "boolean"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            },
                                                            "prefix": {
                                                                "description": "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER.",
                                                                "type": "string"
                                                            },
                                                            "secretRef": {
                                                                "description": "The Secret to select from",
                                                                "properties": {
                                                                    "name": {
                                                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                        "type": "string"
                                                                    },
                                                                    "optional": {
                                                                        "description": "Specify whether the Secret must be defined",
                                                                        "type": "boolean"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            }
                                                        },
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "image": {
                                                    "description": "Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets.",
                                                    "type": "string"
                                                },
                                                "imagePullPolicy": {
                                                    "description": "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images",
                                                    "type": "string"
                                                },
                                                "lifecycle": {
                                                    "description": "Actions that the management system should take in response to container lifecycle events. Cannot be updated.",
                                                    "properties": {
                                                        "postStart": {
                                                            "description": "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks",
                                                            "properties": {
                                                                "exec": {
                                                                    "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                                    "properties": {
                                                                        "command": {
                                                                            "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                            "items": {
                                                                                "type": "string"
                                                                            },
                                                                            "type": "array"
                                                                        }
                                                                    },
                                                                    "type": "object"
                                                                },
                                                                "httpGet": {
                                                                    "description": "HTTPGet specifies the http request to perform.",
                                                                    "properties": {
                                                                        "host": {
                                                                            "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                            "type": "string"
                                                                        },
                                                                        "httpHeaders": {
                                                                            "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                            "items": {
                                                                                "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                                "properties": {
                                                                                    "name": {
                                                                                        "description": "The header field name",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "value": {
                                                                                        "description": "The header field value",
                                                                                        "type": "string"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "name",
                                                                                    "value"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "path": {
                                                                            "description": "Path to access on the HTTP server.",
                                                                            "type": "string"
                                                                        },
                                                                        "port": {
                                                                            "anyOf": [
                                                                                {
                                                                                    "type": "integer"
                                                                                },
                                                                                {
                                                                                    "type": "string"
                                                                                }
                                                                            ],
                                                                            "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                            "x-kubernetes-int-or-string": true
                                                                        },
                                                                        "scheme": {
                                                                            "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                            "type": "string"
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "port"
                                                                    ],
                                                                    "type": "object"
                                                                },
                                                                "tcpSocket": {
                                                                    "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                                    "properties": {
                                                                        "host": {
                                                                            "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                            "type": "string"
                                                                        },
                                                                        "port": {
                                                                            "anyOf": [
                                                                                {
                                                                                    "type": "integer"
                                                                                },
                                                                                {
                                                                                    "type": "string"
                                                                                }
                                                                            ],
                                                                            "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                            "x-kubernetes-int-or-string": true
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "port"
                                                                    ],
                                                                    "type": "object"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "preStop": {
                                                            "description": "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The reason for termination is passed to the handler. The Pod's termination grace period countdown begins before the PreStop hooked is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period. Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks",
                                                            "properties": {
                                                                "exec": {
                                                                    "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                                    "properties": {
                                                                        "command": {
                                                                            "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                            "items": {
                                                                                "type": "string"
                                                                            },
                                                                            "type": "array"
                                                                        }
                                                                    },
                                                                    "type": "object"
                                                                },
                                                                "httpGet": {
                                                                    "description": "HTTPGet specifies the http request to perform.",
                                                                    "properties": {
                                                                        "host": {
                                                                            "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                            "type": "string"
                                                                        },
                                                                        "httpHeaders": {
                                                                            "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                            "items": {
                                                                                "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                                "properties": {
                                                                                    "name": {
                                                                                        "description": "The header field name",
                                                                                        "type": "string"
                                                                                    },
                                                                                    "value": {
                                                                                        "description": "The header field value",
                                                                                        "type": "string"
                                                                                    }
                                                                                },
                                                                                "required": [
                                                                                    "name",
                                                                                    "value"
                                                                                ],
                                                                                "type": "object"
                                                                            },
                                                                            "type": "array"
                                                                        },
                                                                        "path": {
                                                                            "description": "Path to access on the HTTP server.",
                                                                            "type": "string"
                                                                        },
                                                                        "port": {
                                                                            "anyOf": [
                                                                                {
                                                                                    "type": "integer"
                                                                                },
                                                                                {
                                                                                    "type": "string"
                                                                                }
                                                                            ],
                                                                            "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                            "x-kubernetes-int-or-string": true
                                                                        },
                                                                        "scheme": {
                                                                            "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                            "type": "string"
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "port"
                                                                    ],
                                                                    "type": "object"
                                                                },
                                                                "tcpSocket": {
                                                                    "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                                    "properties": {
                                                                        "host": {
                                                                            "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                            "type": "string"
                                                                        },
                                                                        "port": {
                                                                            "anyOf": [
                                                                                {
                                                                                    "type": "integer"
                                                                                },
                                                                                {
                                                                                    "type": "string"
                                                                                }
                                                                            ],
                                                                            "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                            "x-kubernetes-int-or-string": true
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "port"
                                                                    ],
                                                                    "type": "object"
                                                                }
                                                            },
                                                            "type": "object"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "livenessProbe": {
                                                    "description": "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                    "properties": {
                                                        "exec": {
                                                            "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                            "properties": {
                                                                "command": {
                                                                    "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                    "items": {
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "failureThreshold": {
                                                            "description": "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "httpGet": {
                                                            "description": "HTTPGet specifies the http request to perform.",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                    "type": "string"
                                                                },
                                                                "httpHeaders": {
                                                                    "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                    "items": {
                                                                        "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                        "properties": {
                                                                            "name": {
                                                                                "description": "The header field name",
                                                                                "type": "string"
                                                                            },
                                                                            "value": {
                                                                                "description": "The header field value",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "name",
                                                                            "value"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "path": {
                                                                    "description": "Path to access on the HTTP server.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                },
                                                                "scheme": {
                                                                    "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "initialDelaySeconds": {
                                                            "description": "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "periodSeconds": {
                                                            "description": "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "successThreshold": {
                                                            "description": "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "tcpSocket": {
                                                            "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "timeoutSeconds": {
                                                            "description": "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "name": {
                                                    "description": "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated.",
                                                    "type": "string"
                                                },
                                                "ports": {
                                                    "description": "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated.",
                                                    "items": {
                                                        "description": "ContainerPort represents a network port in a single container.",
                                                        "properties": {
                                                            "containerPort": {
                                                                "description": "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.",
                                                                "format": "int32",
                                                                "type": "integer"
                                                            },
                                                            "hostIP": {
                                                                "description": "What host IP to bind the external port to.",
                                                                "type": "string"
                                                            },
                                                            "hostPort": {
                                                                "description": "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.",
                                                                "format": "int32",
                                                                "type": "integer"
                                                            },
                                                            "name": {
                                                                "description": "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services.",
                                                                "type": "string"
                                                            },
                                                            "protocol": {
                                                                "description": "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\".",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "required": [
                                                            "containerPort"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "readinessProbe": {
                                                    "description": "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                    "properties": {
                                                        "exec": {
                                                            "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                            "properties": {
                                                                "command": {
                                                                    "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                    "items": {
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "failureThreshold": {
                                                            "description": "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "httpGet": {
                                                            "description": "HTTPGet specifies the http request to perform.",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                    "type": "string"
                                                                },
                                                                "httpHeaders": {
                                                                    "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                    "items": {
                                                                        "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                        "properties": {
                                                                            "name": {
                                                                                "description": "The header field name",
                                                                                "type": "string"
                                                                            },
                                                                            "value": {
                                                                                "description": "The header field value",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "name",
                                                                            "value"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "path": {
                                                                    "description": "Path to access on the HTTP server.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                },
                                                                "scheme": {
                                                                    "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "initialDelaySeconds": {
                                                            "description": "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "periodSeconds": {
                                                            "description": "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "successThreshold": {
                                                            "description": "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "tcpSocket": {
                                                            "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "timeoutSeconds": {
                                                            "description": "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "resources": {
                                                    "description": "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                    "properties": {
                                                        "limits": {
                                                            "additionalProperties": {
                                                                "type": "string"
                                                            },
                                                            "description": "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                            "type": "object"
                                                        },
                                                        "requests": {
                                                            "additionalProperties": {
                                                                "type": "string"
                                                            },
                                                            "description": "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                            "type": "object"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "securityContext": {
                                                    "description": "Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/",
                                                    "properties": {
                                                        "allowPrivilegeEscalation": {
                                                            "description": "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN",
                                                            "type": "boolean"
                                                        },
                                                        "capabilities": {
                                                            "description": "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime.",
                                                            "properties": {
                                                                "add": {
                                                                    "description": "Added capabilities",
                                                                    "items": {
                                                                        "description": "Capability represent POSIX capabilities type",
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "drop": {
                                                                    "description": "Removed capabilities",
                                                                    "items": {
                                                                        "description": "Capability represent POSIX capabilities type",
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "privileged": {
                                                            "description": "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false.",
                                                            "type": "boolean"
                                                        },
                                                        "procMount": {
                                                            "description": "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled.",
                                                            "type": "string"
                                                        },
                                                        "readOnlyRootFilesystem": {
                                                            "description": "Whether this container has a read-only root filesystem. Default is false.",
                                                            "type": "boolean"
                                                        },
                                                        "runAsGroup": {
                                                            "description": "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "format": "int64",
                                                            "type": "integer"
                                                        },
                                                        "runAsNonRoot": {
                                                            "description": "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "type": "boolean"
                                                        },
                                                        "runAsUser": {
                                                            "description": "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "format": "int64",
                                                            "type": "integer"
                                                        },
                                                        "seLinuxOptions": {
                                                            "description": "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "properties": {
                                                                "level": {
                                                                    "description": "Level is SELinux level label that applies to the container.",
                                                                    "type": "string"
                                                                },
                                                                "role": {
                                                                    "description": "Role is a SELinux role label that applies to the container.",
                                                                    "type": "string"
                                                                },
                                                                "type": {
                                                                    "description": "Type is a SELinux type label that applies to the container.",
                                                                    "type": "string"
                                                                },
                                                                "user": {
                                                                    "description": "User is a SELinux user label that applies to the container.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "windowsOptions": {
                                                            "description": "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                            "properties": {
                                                                "gmsaCredentialSpec": {
                                                                    "description": "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.",
                                                                    "type": "string"
                                                                },
                                                                "gmsaCredentialSpecName": {
                                                                    "description": "GMSACredentialSpecName is the name of the GMSA credential spec to use.",
                                                                    "type": "string"
                                                                },
                                                                "runAsUserName": {
                                                                    "description": "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "startupProbe": {
                                                    "description": "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. This is a beta feature enabled by the StartupProbe feature flag. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                    "properties": {
                                                        "exec": {
                                                            "description": "One and only one of the following should be specified. Exec specifies the action to take.",
                                                            "properties": {
                                                                "command": {
                                                                    "description": "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.",
                                                                    "items": {
                                                                        "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "failureThreshold": {
                                                            "description": "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "httpGet": {
                                                            "description": "HTTPGet specifies the http request to perform.",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.",
                                                                    "type": "string"
                                                                },
                                                                "httpHeaders": {
                                                                    "description": "Custom headers to set in the request. HTTP allows repeated headers.",
                                                                    "items": {
                                                                        "description": "HTTPHeader describes a custom header to be used in HTTP probes",
                                                                        "properties": {
                                                                            "name": {
                                                                                "description": "The header field name",
                                                                                "type": "string"
                                                                            },
                                                                            "value": {
                                                                                "description": "The header field value",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "name",
                                                                            "value"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "type": "array"
                                                                },
                                                                "path": {
                                                                    "description": "Path to access on the HTTP server.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                },
                                                                "scheme": {
                                                                    "description": "Scheme to use for connecting to the host. Defaults to HTTP.",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "initialDelaySeconds": {
                                                            "description": "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "periodSeconds": {
                                                            "description": "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "successThreshold": {
                                                            "description": "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "tcpSocket": {
                                                            "description": "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook",
                                                            "properties": {
                                                                "host": {
                                                                    "description": "Optional: Host name to connect to, defaults to the pod IP.",
                                                                    "type": "string"
                                                                },
                                                                "port": {
                                                                    "anyOf": [
                                                                        {
                                                                            "type": "integer"
                                                                        },
                                                                        {
                                                                            "type": "string"
                                                                        }
                                                                    ],
                                                                    "description": "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.",
                                                                    "x-kubernetes-int-or-string": true
                                                                }
                                                            },
                                                            "required": [
                                                                "port"
                                                            ],
                                                            "type": "object"
                                                        },
                                                        "timeoutSeconds": {
                                                            "description": "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "stdin": {
                                                    "description": "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false.",
                                                    "type": "boolean"
                                                },
                                                "stdinOnce": {
                                                    "description": "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false",
                                                    "type": "boolean"
                                                },
                                                "terminationMessagePath": {
                                                    "description": "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated.",
                                                    "type": "string"
                                                },
                                                "terminationMessagePolicy": {
                                                    "description": "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated.",
                                                    "type": "string"
                                                },
                                                "tty": {
                                                    "description": "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false.",
                                                    "type": "boolean"
                                                },
                                                "volumeDevices": {
                                                    "description": "volumeDevices is the list of block devices to be used by the container.",
                                                    "items": {
                                                        "description": "volumeDevice describes a mapping of a raw block device within a container.",
                                                        "properties": {
                                                            "devicePath": {
                                                                "description": "devicePath is the path inside of the container that the device will be mapped to.",
                                                                "type": "string"
                                                            },
                                                            "name": {
                                                                "description": "name must match the name of a persistentVolumeClaim in the pod",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "required": [
                                                            "devicePath",
                                                            "name"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "volumeMounts": {
                                                    "description": "Pod volumes to mount into the container's filesystem. Cannot be updated.",
                                                    "items": {
                                                        "description": "VolumeMount describes a mounting of a Volume within a container.",
                                                        "properties": {
                                                            "mountPath": {
                                                                "description": "Path within the container at which the volume should be mounted.  Must not contain ':'.",
                                                                "type": "string"
                                                            },
                                                            "mountPropagation": {
                                                                "description": "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10.",
                                                                "type": "string"
                                                            },
                                                            "name": {
                                                                "description": "This must match the Name of a Volume.",
                                                                "type": "string"
                                                            },
                                                            "readOnly": {
                                                                "description": "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false.",
                                                                "type": "boolean"
                                                            },
                                                            "subPath": {
                                                                "description": "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root).",
                                                                "type": "string"
                                                            },
                                                            "subPathExpr": {
                                                                "description": "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive.",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "required": [
                                                            "mountPath",
                                                            "name"
                                                        ],
                                                        "type": "object"
                                                    },
                                                    "type": "array"
                                                },
                                                "workingDir": {
                                                    "description": "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated.",
                                                    "type": "string"
                                                }
                                            },
                                            "required": [
                                                "name"
                                            ],
                                            "type": "object"
                                        },
                                        "type": "array"
                                    },
                                    "labels": {
                                        "additionalProperties": {
                                            "type": "string"
                                        },
                                        "description": "Labels configure the external label pairs to ThanosRuler. If not provided, default replica label `thanos_ruler_replica` will be added as a label and be dropped in alerts.",
                                        "type": "object"
                                    },
                                    "listenLocal": {
                                        "description": "ListenLocal makes the Thanos ruler listen on loopback, so that it does not bind against the Pod IP.",
                                        "type": "boolean"
                                    },
                                    "logFormat": {
                                        "description": "Log format for ThanosRuler to be configured with.",
                                        "type": "string"
                                    },
                                    "logLevel": {
                                        "description": "Log level for ThanosRuler to be configured with.",
                                        "type": "string"
                                    },
                                    "nodeSelector": {
                                        "additionalProperties": {
                                            "type": "string"
                                        },
                                        "description": "Define which Nodes the Pods are scheduled on.",
                                        "type": "object"
                                    },
                                    "objectStorageConfig": {
                                        "description": "ObjectStorageConfig configures object storage in Thanos.",
                                        "properties": {
                                            "key": {
                                                "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                "type": "string"
                                            },
                                            "name": {
                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                "type": "string"
                                            },
                                            "optional": {
                                                "description": "Specify whether the Secret or its key must be defined",
                                                "type": "boolean"
                                            }
                                        },
                                        "required": [
                                            "key"
                                        ],
                                        "type": "object"
                                    },
                                    "paused": {
                                        "description": "When a ThanosRuler deployment is paused, no actions except for deletion will be performed on the underlying objects.",
                                        "type": "boolean"
                                    },
                                    "podMetadata": {
                                        "description": "PodMetadata contains Labels and Annotations gets propagated to the thanos ruler pods.",
                                        "properties": {
                                            "annotations": {
                                                "additionalProperties": {
                                                    "type": "string"
                                                },
                                                "description": "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations",
                                                "type": "object"
                                            },
                                            "labels": {
                                                "additionalProperties": {
                                                    "type": "string"
                                                },
                                                "description": "Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels",
                                                "type": "object"
                                            },
                                            "name": {
                                                "description": "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names",
                                                "type": "string"
                                            }
                                        },
                                        "type": "object"
                                    },
                                    "portName": {
                                        "description": "Port name used for the pods and governing service. This defaults to web",
                                        "type": "string"
                                    },
                                    "priorityClassName": {
                                        "description": "Priority class assigned to the Pods",
                                        "type": "string"
                                    },
                                    "prometheusRulesExcludedFromEnforce": {
                                        "description": "PrometheusRulesExcludedFromEnforce - list of Prometheus rules to be excluded from enforcing of adding namespace labels. Works only if enforcedNamespaceLabel set to true. Make sure both ruleNamespace and ruleName are set for each pair",
                                        "items": {
                                            "description": "PrometheusRuleExcludeConfig enables users to configure excluded PrometheusRule names and their namespaces to be ignored while enforcing namespace label for alerts and metrics.",
                                            "properties": {
                                                "ruleName": {
                                                    "description": "RuleNamespace - name of excluded rule",
                                                    "type": "string"
                                                },
                                                "ruleNamespace": {
                                                    "description": "RuleNamespace - namespace of excluded rule",
                                                    "type": "string"
                                                }
                                            },
                                            "required": [
                                                "ruleName",
                                                "ruleNamespace"
                                            ],
                                            "type": "object"
                                        },
                                        "type": "array"
                                    },
                                    "queryConfig": {
                                        "description": "Define configuration for connecting to thanos query instances. If this is defined, the QueryEndpoints field will be ignored. Maps to the `query.config` CLI argument. Only available with thanos v0.11.0 and higher.",
                                        "properties": {
                                            "key": {
                                                "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                "type": "string"
                                            },
                                            "name": {
                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                "type": "string"
                                            },
                                            "optional": {
                                                "description": "Specify whether the Secret or its key must be defined",
                                                "type": "boolean"
                                            }
                                        },
                                        "required": [
                                            "key"
                                        ],
                                        "type": "object"
                                    },
                                    "queryEndpoints": {
                                        "description": "QueryEndpoints defines Thanos querier endpoints from which to query metrics. Maps to the --query flag of thanos ruler.",
                                        "items": {
                                            "type": "string"
                                        },
                                        "type": "array"
                                    },
                                    "replicas": {
                                        "description": "Number of thanos ruler instances to deploy.",
                                        "format": "int32",
                                        "type": "integer"
                                    },
                                    "resources": {
                                        "description": "Resources defines the resource requirements for single Pods. If not provided, no requests/limits will be set",
                                        "properties": {
                                            "limits": {
                                                "additionalProperties": {
                                                    "type": "string"
                                                },
                                                "description": "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                "type": "object"
                                            },
                                            "requests": {
                                                "additionalProperties": {
                                                    "type": "string"
                                                },
                                                "description": "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                "type": "object"
                                            }
                                        },
                                        "type": "object"
                                    },
                                    "retention": {
                                        "description": "Time duration ThanosRuler shall retain data for. Default is '24h', and must match the regular expression `[0-9]+(ms|s|m|h|d|w|y)` (milliseconds seconds minutes hours days weeks years).",
                                        "type": "string"
                                    },
                                    "routePrefix": {
                                        "description": "The route prefix ThanosRuler registers HTTP handlers for. This allows thanos UI to be served on a sub-path.",
                                        "type": "string"
                                    },
                                    "ruleNamespaceSelector": {
                                        "description": "Namespaces to be selected for Rules discovery. If unspecified, only the same namespace as the ThanosRuler object is in is used.",
                                        "properties": {
                                            "matchExpressions": {
                                                "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                "items": {
                                                    "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                    "properties": {
                                                        "key": {
                                                            "description": "key is the label key that the selector applies to.",
                                                            "type": "string"
                                                        },
                                                        "operator": {
                                                            "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                            "type": "string"
                                                        },
                                                        "values": {
                                                            "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                            "items": {
                                                                "type": "string"
                                                            },
                                                            "type": "array"
                                                        }
                                                    },
                                                    "required": [
                                                        "key",
                                                        "operator"
                                                    ],
                                                    "type": "object"
                                                },
                                                "type": "array"
                                            },
                                            "matchLabels": {
                                                "additionalProperties": {
                                                    "type": "string"
                                                },
                                                "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                "type": "object"
                                            }
                                        },
                                        "type": "object"
                                    },
                                    "ruleSelector": {
                                        "description": "A label selector to select which PrometheusRules to mount for alerting and recording.",
                                        "properties": {
                                            "matchExpressions": {
                                                "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                "items": {
                                                    "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                    "properties": {
                                                        "key": {
                                                            "description": "key is the label key that the selector applies to.",
                                                            "type": "string"
                                                        },
                                                        "operator": {
                                                            "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                            "type": "string"
                                                        },
                                                        "values": {
                                                            "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                            "items": {
                                                                "type": "string"
                                                            },
                                                            "type": "array"
                                                        }
                                                    },
                                                    "required": [
                                                        "key",
                                                        "operator"
                                                    ],
                                                    "type": "object"
                                                },
                                                "type": "array"
                                            },
                                            "matchLabels": {
                                                "additionalProperties": {
                                                    "type": "string"
                                                },
                                                "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                "type": "object"
                                            }
                                        },
                                        "type": "object"
                                    },
                                    "securityContext": {
                                        "description": "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext.",
                                        "properties": {
                                            "fsGroup": {
                                                "description": "A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod: \n 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw---- \n If unset, the Kubelet will not modify the ownership and permissions of any volume.",
                                                "format": "int64",
                                                "type": "integer"
                                            },
                                            "fsGroupChangePolicy": {
                                                "description": "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified defaults to \"Always\".",
                                                "type": "string"
                                            },
                                            "runAsGroup": {
                                                "description": "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.",
                                                "format": "int64",
                                                "type": "integer"
                                            },
                                            "runAsNonRoot": {
                                                "description": "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                "type": "boolean"
                                            },
                                            "runAsUser": {
                                                "description": "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.",
                                                "format": "int64",
                                                "type": "integer"
                                            },
                                            "seLinuxOptions": {
                                                "description": "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.",
                                                "properties": {
                                                    "level": {
                                                        "description": "Level is SELinux level label that applies to the container.",
                                                        "type": "string"
                                                    },
                                                    "role": {
                                                        "description": "Role is a SELinux role label that applies to the container.",
                                                        "type": "string"
                                                    },
                                                    "type": {
                                                        "description": "Type is a SELinux type label that applies to the container.",
                                                        "type": "string"
                                                    },
                                                    "user": {
                                                        "description": "User is a SELinux user label that applies to the container.",
                                                        "type": "string"
                                                    }
                                                },
                                                "type": "object"
                                            },
                                            "supplementalGroups": {
                                                "description": "A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container.",
                                                "items": {
                                                    "format": "int64",
                                                    "type": "integer"
                                                },
                                                "type": "array"
                                            },
                                            "sysctls": {
                                                "description": "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch.",
                                                "items": {
                                                    "description": "Sysctl defines a kernel parameter to be set",
                                                    "properties": {
                                                        "name": {
                                                            "description": "Name of a property to set",
                                                            "type": "string"
                                                        },
                                                        "value": {
                                                            "description": "Value of a property to set",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "name",
                                                        "value"
                                                    ],
                                                    "type": "object"
                                                },
                                                "type": "array"
                                            },
                                            "windowsOptions": {
                                                "description": "The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                "properties": {
                                                    "gmsaCredentialSpec": {
                                                        "description": "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.",
                                                        "type": "string"
                                                    },
                                                    "gmsaCredentialSpecName": {
                                                        "description": "GMSACredentialSpecName is the name of the GMSA credential spec to use.",
                                                        "type": "string"
                                                    },
                                                    "runAsUserName": {
                                                        "description": "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.",
                                                        "type": "string"
                                                    }
                                                },
                                                "type": "object"
                                            }
                                        },
                                        "type": "object"
                                    },
                                    "serviceAccountName": {
                                        "description": "ServiceAccountName is the name of the ServiceAccount to use to run the Thanos Ruler Pods.",
                                        "type": "string"
                                    },
                                    "storage": {
                                        "description": "Storage spec to specify how storage shall be used.",
                                        "properties": {
                                            "disableMountSubPath": {
                                                "description": "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts.",
                                                "type": "boolean"
                                            },
                                            "emptyDir": {
                                                "description": "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir",
                                                "properties": {
                                                    "medium": {
                                                        "description": "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir",
                                                        "type": "string"
                                                    },
                                                    "sizeLimit": {
                                                        "description": "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir",
                                                        "type": "string"
                                                    }
                                                },
                                                "type": "object"
                                            },
                                            "volumeClaimTemplate": {
                                                "description": "A PVC spec to be used by the Prometheus StatefulSets.",
                                                "properties": {
                                                    "apiVersion": {
                                                        "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
                                                        "type": "string"
                                                    },
                                                    "kind": {
                                                        "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
                                                        "type": "string"
                                                    },
                                                    "metadata": {
                                                        "description": "EmbeddedMetadata contains metadata relevant to an EmbeddedResource.",
                                                        "properties": {
                                                            "annotations": {
                                                                "additionalProperties": {
                                                                    "type": "string"
                                                                },
                                                                "description": "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations",
                                                                "type": "object"
                                                            },
                                                            "labels": {
                                                                "additionalProperties": {
                                                                    "type": "string"
                                                                },
                                                                "description": "Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels",
                                                                "type": "object"
                                                            },
                                                            "name": {
                                                                "description": "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "type": "object"
                                                    },
                                                    "spec": {
                                                        "description": "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims",
                                                        "properties": {
                                                            "accessModes": {
                                                                "description": "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1",
                                                                "items": {
                                                                    "type": "string"
                                                                },
                                                                "type": "array"
                                                            },
                                                            "dataSource": {
                                                                "description": "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot - Beta) * An existing PVC (PersistentVolumeClaim) * An existing custom resource/object that implements data population (Alpha) In order to use VolumeSnapshot object types, the appropriate feature gate must be enabled (VolumeSnapshotDataSource or AnyVolumeDataSource) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the specified data source is not supported, the volume will not be created and the failure will be reported as an event. In the future, we plan to support more data source types and the behavior of the provisioner may change.",
                                                                "properties": {
                                                                    "apiGroup": {
                                                                        "description": "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.",
                                                                        "type": "string"
                                                                    },
                                                                    "kind": {
                                                                        "description": "Kind is the type of resource being referenced",
                                                                        "type": "string"
                                                                    },
                                                                    "name": {
                                                                        "description": "Name is the name of resource being referenced",
                                                                        "type": "string"
                                                                    }
                                                                },
                                                                "required": [
                                                                    "kind",
                                                                    "name"
                                                                ],
                                                                "type": "object"
                                                            },
                                                            "resources": {
                                                                "description": "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources",
                                                                "properties": {
                                                                    "limits": {
                                                                        "additionalProperties": {
                                                                            "type": "string"
                                                                        },
                                                                        "description": "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                                        "type": "object"
                                                                    },
                                                                    "requests": {
                                                                        "additionalProperties": {
                                                                            "type": "string"
                                                                        },
                                                                        "description": "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/",
                                                                        "type": "object"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            },
                                                            "selector": {
                                                                "description": "A label query over volumes to consider for binding.",
                                                                "properties": {
                                                                    "matchExpressions": {
                                                                        "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                        "items": {
                                                                            "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                            "properties": {
                                                                                "key": {
                                                                                    "description": "key is the label key that the selector applies to.",
                                                                                    "type": "string"
                                                                                },
                                                                                "operator": {
                                                                                    "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                                    "type": "string"
                                                                                },
                                                                                "values": {
                                                                                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                                    "items": {
                                                                                        "type": "string"
                                                                                    },
                                                                                    "type": "array"
                                                                                }
                                                                            },
                                                                            "required": [
                                                                                "key",
                                                                                "operator"
                                                                            ],
                                                                            "type": "object"
                                                                        },
                                                                        "type": "array"
                                                                    },
                                                                    "matchLabels": {
                                                                        "additionalProperties": {
                                                                            "type": "string"
                                                                        },
                                                                        "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                        "type": "object"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            },
                                                            "storageClassName": {
                                                                "description": "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1",
                                                                "type": "string"
                                                            },
                                                            "volumeMode": {
                                                                "description": "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec.",
                                                                "type": "string"
                                                            },
                                                            "volumeName": {
                                                                "description": "VolumeName is the binding reference to the PersistentVolume backing this claim.",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "type": "object"
                                                    },
                                                    "status": {
                                                        "description": "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims",
                                                        "properties": {
                                                            "accessModes": {
                                                                "description": "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1",
                                                                "items": {
                                                                    "type": "string"
                                                                },
                                                                "type": "array"
                                                            },
                                                            "capacity": {
                                                                "additionalProperties": {
                                                                    "type": "string"
                                                                },
                                                                "description": "Represents the actual resources of the underlying volume.",
                                                                "type": "object"
                                                            },
                                                            "conditions": {
                                                                "description": "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'.",
                                                                "items": {
                                                                    "description": "PersistentVolumeClaimCondition contails details about state of pvc",
                                                                    "properties": {
                                                                        "lastProbeTime": {
                                                                            "description": "Last time we probed the condition.",
                                                                            "format": "date-time",
                                                                            "type": "string"
                                                                        },
                                                                        "lastTransitionTime": {
                                                                            "description": "Last time the condition transitioned from one status to another.",
                                                                            "format": "date-time",
                                                                            "type": "string"
                                                                        },
                                                                        "message": {
                                                                            "description": "Human-readable message indicating details about last transition.",
                                                                            "type": "string"
                                                                        },
                                                                        "reason": {
                                                                            "description": "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized.",
                                                                            "type": "string"
                                                                        },
                                                                        "status": {
                                                                            "type": "string"
                                                                        },
                                                                        "type": {
                                                                            "description": "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type",
                                                                            "type": "string"
                                                                        }
                                                                    },
                                                                    "required": [
                                                                        "status",
                                                                        "type"
                                                                    ],
                                                                    "type": "object"
                                                                },
                                                                "type": "array"
                                                            },
                                                            "phase": {
                                                                "description": "Phase represents the current phase of PersistentVolumeClaim.",
                                                                "type": "string"
                                                            }
                                                        },
                                                        "type": "object"
                                                    }
                                                },
                                                "type": "object"
                                            }
                                        },
                                        "type": "object"
                                    },
                                    "tolerations": {
                                        "description": "If specified, the pod's tolerations.",
                                        "items": {
                                            "description": "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>.",
                                            "properties": {
                                                "effect": {
                                                    "description": "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.",
                                                    "type": "string"
                                                },
                                                "key": {
                                                    "description": "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.",
                                                    "type": "string"
                                                },
                                                "operator": {
                                                    "description": "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.",
                                                    "type": "string"
                                                },
                                                "tolerationSeconds": {
                                                    "description": "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.",
                                                    "format": "int64",
                                                    "type": "integer"
                                                },
                                                "value": {
                                                    "description": "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.",
                                                    "type": "string"
                                                }
                                            },
                                            "type": "object"
                                        },
                                        "type": "array"
                                    },
                                    "tracingConfig": {
                                        "description": "TracingConfig configures tracing in Thanos. This is an experimental feature, it may change in any upcoming release in a breaking way.",
                                        "properties": {
                                            "key": {
                                                "description": "The key of the secret to select from.  Must be a valid secret key.",
                                                "type": "string"
                                            },
                                            "name": {
                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                "type": "string"
                                            },
                                            "optional": {
                                                "description": "Specify whether the Secret or its key must be defined",
                                                "type": "boolean"
                                            }
                                        },
                                        "required": [
                                            "key"
                                        ],
                                        "type": "object"
                                    },
                                    "volumes": {
                                        "description": "Volumes allows configuration of additional volumes on the output StatefulSet definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects.",
                                        "items": {
                                            "description": "Volume represents a named volume in a pod that may be accessed by any container in the pod.",
                                            "properties": {
                                                "awsElasticBlockStore": {
                                                    "description": "AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine",
                                                            "type": "string"
                                                        },
                                                        "partition": {
                                                            "description": "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty).",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "readOnly": {
                                                            "description": "Specify \"true\" to force and set the ReadOnly property in VolumeMounts to \"true\". If omitted, the default is \"false\". More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore",
                                                            "type": "boolean"
                                                        },
                                                        "volumeID": {
                                                            "description": "Unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "volumeID"
                                                    ],
                                                    "type": "object"
                                                },
                                                "azureDisk": {
                                                    "description": "AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.",
                                                    "properties": {
                                                        "cachingMode": {
                                                            "description": "Host Caching mode: None, Read Only, Read Write.",
                                                            "type": "string"
                                                        },
                                                        "diskName": {
                                                            "description": "The Name of the data disk in the blob storage",
                                                            "type": "string"
                                                        },
                                                        "diskURI": {
                                                            "description": "The URI the data disk in the blob storage",
                                                            "type": "string"
                                                        },
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.",
                                                            "type": "string"
                                                        },
                                                        "kind": {
                                                            "description": "Expected values Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.",
                                                            "type": "boolean"
                                                        }
                                                    },
                                                    "required": [
                                                        "diskName",
                                                        "diskURI"
                                                    ],
                                                    "type": "object"
                                                },
                                                "azureFile": {
                                                    "description": "AzureFile represents an Azure File Service mount on the host and bind mount to the pod.",
                                                    "properties": {
                                                        "readOnly": {
                                                            "description": "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.",
                                                            "type": "boolean"
                                                        },
                                                        "secretName": {
                                                            "description": "the name of secret that contains Azure Storage Account Name and Key",
                                                            "type": "string"
                                                        },
                                                        "shareName": {
                                                            "description": "Share Name",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "secretName",
                                                        "shareName"
                                                    ],
                                                    "type": "object"
                                                },
                                                "cephfs": {
                                                    "description": "CephFS represents a Ceph FS mount on the host that shares a pod's lifetime",
                                                    "properties": {
                                                        "monitors": {
                                                            "description": "Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it",
                                                            "items": {
                                                                "type": "string"
                                                            },
                                                            "type": "array"
                                                        },
                                                        "path": {
                                                            "description": "Optional: Used as the mounted root, rather than the full Ceph tree, default is /",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it",
                                                            "type": "boolean"
                                                        },
                                                        "secretFile": {
                                                            "description": "Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it",
                                                            "type": "string"
                                                        },
                                                        "secretRef": {
                                                            "description": "Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it",
                                                            "properties": {
                                                                "name": {
                                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "user": {
                                                            "description": "Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "monitors"
                                                    ],
                                                    "type": "object"
                                                },
                                                "cinder": {
                                                    "description": "Cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md",
                                                            "type": "boolean"
                                                        },
                                                        "secretRef": {
                                                            "description": "Optional: points to a secret object containing parameters used to connect to OpenStack.",
                                                            "properties": {
                                                                "name": {
                                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "volumeID": {
                                                            "description": "volume id used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "volumeID"
                                                    ],
                                                    "type": "object"
                                                },
                                                "configMap": {
                                                    "description": "ConfigMap represents a configMap that should populate this volume",
                                                    "properties": {
                                                        "defaultMode": {
                                                            "description": "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "items": {
                                                            "description": "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.",
                                                            "items": {
                                                                "description": "Maps a string key to a path within a volume.",
                                                                "properties": {
                                                                    "key": {
                                                                        "description": "The key to project.",
                                                                        "type": "string"
                                                                    },
                                                                    "mode": {
                                                                        "description": "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                                        "format": "int32",
                                                                        "type": "integer"
                                                                    },
                                                                    "path": {
                                                                        "description": "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'.",
                                                                        "type": "string"
                                                                    }
                                                                },
                                                                "required": [
                                                                    "key",
                                                                    "path"
                                                                ],
                                                                "type": "object"
                                                            },
                                                            "type": "array"
                                                        },
                                                        "name": {
                                                            "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                            "type": "string"
                                                        },
                                                        "optional": {
                                                            "description": "Specify whether the ConfigMap or its keys must be defined",
                                                            "type": "boolean"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "csi": {
                                                    "description": "CSI (Container Storage Interface) represents storage that is handled by an external CSI driver (Alpha feature).",
                                                    "properties": {
                                                        "driver": {
                                                            "description": "Driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster.",
                                                            "type": "string"
                                                        },
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Ex. \"ext4\", \"xfs\", \"ntfs\". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply.",
                                                            "type": "string"
                                                        },
                                                        "nodePublishSecretRef": {
                                                            "description": "NodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed.",
                                                            "properties": {
                                                                "name": {
                                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "readOnly": {
                                                            "description": "Specifies a read-only configuration for the volume. Defaults to false (read/write).",
                                                            "type": "boolean"
                                                        },
                                                        "volumeAttributes": {
                                                            "additionalProperties": {
                                                                "type": "string"
                                                            },
                                                            "description": "VolumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values.",
                                                            "type": "object"
                                                        }
                                                    },
                                                    "required": [
                                                        "driver"
                                                    ],
                                                    "type": "object"
                                                },
                                                "downwardAPI": {
                                                    "description": "DownwardAPI represents downward API about the pod that should populate this volume",
                                                    "properties": {
                                                        "defaultMode": {
                                                            "description": "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "items": {
                                                            "description": "Items is a list of downward API volume file",
                                                            "items": {
                                                                "description": "DownwardAPIVolumeFile represents information to create the file containing the pod field",
                                                                "properties": {
                                                                    "fieldRef": {
                                                                        "description": "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported.",
                                                                        "properties": {
                                                                            "apiVersion": {
                                                                                "description": "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".",
                                                                                "type": "string"
                                                                            },
                                                                            "fieldPath": {
                                                                                "description": "Path of the field to select in the specified API version.",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "fieldPath"
                                                                        ],
                                                                        "type": "object"
                                                                    },
                                                                    "mode": {
                                                                        "description": "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                                        "format": "int32",
                                                                        "type": "integer"
                                                                    },
                                                                    "path": {
                                                                        "description": "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'",
                                                                        "type": "string"
                                                                    },
                                                                    "resourceFieldRef": {
                                                                        "description": "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.",
                                                                        "properties": {
                                                                            "containerName": {
                                                                                "description": "Container name: required for volumes, optional for env vars",
                                                                                "type": "string"
                                                                            },
                                                                            "divisor": {
                                                                                "description": "Specifies the output format of the exposed resources, defaults to \"1\"",
                                                                                "type": "string"
                                                                            },
                                                                            "resource": {
                                                                                "description": "Required: resource to select",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "resource"
                                                                        ],
                                                                        "type": "object"
                                                                    }
                                                                },
                                                                "required": [
                                                                    "path"
                                                                ],
                                                                "type": "object"
                                                            },
                                                            "type": "array"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "emptyDir": {
                                                    "description": "EmptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir",
                                                    "properties": {
                                                        "medium": {
                                                            "description": "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir",
                                                            "type": "string"
                                                        },
                                                        "sizeLimit": {
                                                            "description": "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "fc": {
                                                    "description": "FC represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine",
                                                            "type": "string"
                                                        },
                                                        "lun": {
                                                            "description": "Optional: FC target lun number",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "readOnly": {
                                                            "description": "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.",
                                                            "type": "boolean"
                                                        },
                                                        "targetWWNs": {
                                                            "description": "Optional: FC target worldwide names (WWNs)",
                                                            "items": {
                                                                "type": "string"
                                                            },
                                                            "type": "array"
                                                        },
                                                        "wwids": {
                                                            "description": "Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously.",
                                                            "items": {
                                                                "type": "string"
                                                            },
                                                            "type": "array"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "flexVolume": {
                                                    "description": "FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.",
                                                    "properties": {
                                                        "driver": {
                                                            "description": "Driver is the name of the driver to use for this volume.",
                                                            "type": "string"
                                                        },
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script.",
                                                            "type": "string"
                                                        },
                                                        "options": {
                                                            "additionalProperties": {
                                                                "type": "string"
                                                            },
                                                            "description": "Optional: Extra command options if any.",
                                                            "type": "object"
                                                        },
                                                        "readOnly": {
                                                            "description": "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.",
                                                            "type": "boolean"
                                                        },
                                                        "secretRef": {
                                                            "description": "Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts.",
                                                            "properties": {
                                                                "name": {
                                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        }
                                                    },
                                                    "required": [
                                                        "driver"
                                                    ],
                                                    "type": "object"
                                                },
                                                "flocker": {
                                                    "description": "Flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running",
                                                    "properties": {
                                                        "datasetName": {
                                                            "description": "Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated",
                                                            "type": "string"
                                                        },
                                                        "datasetUUID": {
                                                            "description": "UUID of the dataset. This is unique identifier of a Flocker dataset",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "gcePersistentDisk": {
                                                    "description": "GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine",
                                                            "type": "string"
                                                        },
                                                        "partition": {
                                                            "description": "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "pdName": {
                                                            "description": "Unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk",
                                                            "type": "boolean"
                                                        }
                                                    },
                                                    "required": [
                                                        "pdName"
                                                    ],
                                                    "type": "object"
                                                },
                                                "gitRepo": {
                                                    "description": "GitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container.",
                                                    "properties": {
                                                        "directory": {
                                                            "description": "Target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name.",
                                                            "type": "string"
                                                        },
                                                        "repository": {
                                                            "description": "Repository URL",
                                                            "type": "string"
                                                        },
                                                        "revision": {
                                                            "description": "Commit hash for the specified revision.",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "repository"
                                                    ],
                                                    "type": "object"
                                                },
                                                "glusterfs": {
                                                    "description": "Glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md",
                                                    "properties": {
                                                        "endpoints": {
                                                            "description": "EndpointsName is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod",
                                                            "type": "string"
                                                        },
                                                        "path": {
                                                            "description": "Path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod",
                                                            "type": "boolean"
                                                        }
                                                    },
                                                    "required": [
                                                        "endpoints",
                                                        "path"
                                                    ],
                                                    "type": "object"
                                                },
                                                "hostPath": {
                                                    "description": "HostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write.",
                                                    "properties": {
                                                        "path": {
                                                            "description": "Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath",
                                                            "type": "string"
                                                        },
                                                        "type": {
                                                            "description": "Type for HostPath Volume Defaults to \"\" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "path"
                                                    ],
                                                    "type": "object"
                                                },
                                                "iscsi": {
                                                    "description": "ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md",
                                                    "properties": {
                                                        "chapAuthDiscovery": {
                                                            "description": "whether support iSCSI Discovery CHAP authentication",
                                                            "type": "boolean"
                                                        },
                                                        "chapAuthSession": {
                                                            "description": "whether support iSCSI Session CHAP authentication",
                                                            "type": "boolean"
                                                        },
                                                        "fsType": {
                                                            "description": "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi TODO: how do we prevent errors in the filesystem from compromising the machine",
                                                            "type": "string"
                                                        },
                                                        "initiatorName": {
                                                            "description": "Custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection.",
                                                            "type": "string"
                                                        },
                                                        "iqn": {
                                                            "description": "Target iSCSI Qualified Name.",
                                                            "type": "string"
                                                        },
                                                        "iscsiInterface": {
                                                            "description": "iSCSI Interface Name that uses an iSCSI transport. Defaults to 'default' (tcp).",
                                                            "type": "string"
                                                        },
                                                        "lun": {
                                                            "description": "iSCSI Target Lun number.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "portals": {
                                                            "description": "iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).",
                                                            "items": {
                                                                "type": "string"
                                                            },
                                                            "type": "array"
                                                        },
                                                        "readOnly": {
                                                            "description": "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false.",
                                                            "type": "boolean"
                                                        },
                                                        "secretRef": {
                                                            "description": "CHAP Secret for iSCSI target and initiator authentication",
                                                            "properties": {
                                                                "name": {
                                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "targetPortal": {
                                                            "description": "iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "iqn",
                                                        "lun",
                                                        "targetPortal"
                                                    ],
                                                    "type": "object"
                                                },
                                                "name": {
                                                    "description": "Volume's name. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names",
                                                    "type": "string"
                                                },
                                                "nfs": {
                                                    "description": "NFS represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs",
                                                    "properties": {
                                                        "path": {
                                                            "description": "Path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "ReadOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs",
                                                            "type": "boolean"
                                                        },
                                                        "server": {
                                                            "description": "Server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "path",
                                                        "server"
                                                    ],
                                                    "type": "object"
                                                },
                                                "persistentVolumeClaim": {
                                                    "description": "PersistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims",
                                                    "properties": {
                                                        "claimName": {
                                                            "description": "ClaimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "Will force the ReadOnly setting in VolumeMounts. Default false.",
                                                            "type": "boolean"
                                                        }
                                                    },
                                                    "required": [
                                                        "claimName"
                                                    ],
                                                    "type": "object"
                                                },
                                                "photonPersistentDisk": {
                                                    "description": "PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.",
                                                            "type": "string"
                                                        },
                                                        "pdID": {
                                                            "description": "ID that identifies Photon Controller persistent disk",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "pdID"
                                                    ],
                                                    "type": "object"
                                                },
                                                "portworxVolume": {
                                                    "description": "PortworxVolume represents a portworx volume attached and mounted on kubelets host machine",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "FSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified.",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.",
                                                            "type": "boolean"
                                                        },
                                                        "volumeID": {
                                                            "description": "VolumeID uniquely identifies a Portworx volume",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "volumeID"
                                                    ],
                                                    "type": "object"
                                                },
                                                "projected": {
                                                    "description": "Items for all in one resources secrets, configmaps, and downward API",
                                                    "properties": {
                                                        "defaultMode": {
                                                            "description": "Mode bits to use on created files by default. Must be a value between 0 and 0777. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "sources": {
                                                            "description": "list of volume projections",
                                                            "items": {
                                                                "description": "Projection that may be projected along with other supported volume types",
                                                                "properties": {
                                                                    "configMap": {
                                                                        "description": "information about the configMap data to project",
                                                                        "properties": {
                                                                            "items": {
                                                                                "description": "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.",
                                                                                "items": {
                                                                                    "description": "Maps a string key to a path within a volume.",
                                                                                    "properties": {
                                                                                        "key": {
                                                                                            "description": "The key to project.",
                                                                                            "type": "string"
                                                                                        },
                                                                                        "mode": {
                                                                                            "description": "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                                                            "format": "int32",
                                                                                            "type": "integer"
                                                                                        },
                                                                                        "path": {
                                                                                            "description": "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'.",
                                                                                            "type": "string"
                                                                                        }
                                                                                    },
                                                                                    "required": [
                                                                                        "key",
                                                                                        "path"
                                                                                    ],
                                                                                    "type": "object"
                                                                                },
                                                                                "type": "array"
                                                                            },
                                                                            "name": {
                                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                                "type": "string"
                                                                            },
                                                                            "optional": {
                                                                                "description": "Specify whether the ConfigMap or its keys must be defined",
                                                                                "type": "boolean"
                                                                            }
                                                                        },
                                                                        "type": "object"
                                                                    },
                                                                    "downwardAPI": {
                                                                        "description": "information about the downwardAPI data to project",
                                                                        "properties": {
                                                                            "items": {
                                                                                "description": "Items is a list of DownwardAPIVolume file",
                                                                                "items": {
                                                                                    "description": "DownwardAPIVolumeFile represents information to create the file containing the pod field",
                                                                                    "properties": {
                                                                                        "fieldRef": {
                                                                                            "description": "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported.",
                                                                                            "properties": {
                                                                                                "apiVersion": {
                                                                                                    "description": "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".",
                                                                                                    "type": "string"
                                                                                                },
                                                                                                "fieldPath": {
                                                                                                    "description": "Path of the field to select in the specified API version.",
                                                                                                    "type": "string"
                                                                                                }
                                                                                            },
                                                                                            "required": [
                                                                                                "fieldPath"
                                                                                            ],
                                                                                            "type": "object"
                                                                                        },
                                                                                        "mode": {
                                                                                            "description": "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                                                            "format": "int32",
                                                                                            "type": "integer"
                                                                                        },
                                                                                        "path": {
                                                                                            "description": "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'",
                                                                                            "type": "string"
                                                                                        },
                                                                                        "resourceFieldRef": {
                                                                                            "description": "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.",
                                                                                            "properties": {
                                                                                                "containerName": {
                                                                                                    "description": "Container name: required for volumes, optional for env vars",
                                                                                                    "type": "string"
                                                                                                },
                                                                                                "divisor": {
                                                                                                    "description": "Specifies the output format of the exposed resources, defaults to \"1\"",
                                                                                                    "type": "string"
                                                                                                },
                                                                                                "resource": {
                                                                                                    "description": "Required: resource to select",
                                                                                                    "type": "string"
                                                                                                }
                                                                                            },
                                                                                            "required": [
                                                                                                "resource"
                                                                                            ],
                                                                                            "type": "object"
                                                                                        }
                                                                                    },
                                                                                    "required": [
                                                                                        "path"
                                                                                    ],
                                                                                    "type": "object"
                                                                                },
                                                                                "type": "array"
                                                                            }
                                                                        },
                                                                        "type": "object"
                                                                    },
                                                                    "secret": {
                                                                        "description": "information about the secret data to project",
                                                                        "properties": {
                                                                            "items": {
                                                                                "description": "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.",
                                                                                "items": {
                                                                                    "description": "Maps a string key to a path within a volume.",
                                                                                    "properties": {
                                                                                        "key": {
                                                                                            "description": "The key to project.",
                                                                                            "type": "string"
                                                                                        },
                                                                                        "mode": {
                                                                                            "description": "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                                                            "format": "int32",
                                                                                            "type": "integer"
                                                                                        },
                                                                                        "path": {
                                                                                            "description": "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'.",
                                                                                            "type": "string"
                                                                                        }
                                                                                    },
                                                                                    "required": [
                                                                                        "key",
                                                                                        "path"
                                                                                    ],
                                                                                    "type": "object"
                                                                                },
                                                                                "type": "array"
                                                                            },
                                                                            "name": {
                                                                                "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                                "type": "string"
                                                                            },
                                                                            "optional": {
                                                                                "description": "Specify whether the Secret or its key must be defined",
                                                                                "type": "boolean"
                                                                            }
                                                                        },
                                                                        "type": "object"
                                                                    },
                                                                    "serviceAccountToken": {
                                                                        "description": "information about the serviceAccountToken data to project",
                                                                        "properties": {
                                                                            "audience": {
                                                                                "description": "Audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver.",
                                                                                "type": "string"
                                                                            },
                                                                            "expirationSeconds": {
                                                                                "description": "ExpirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes.",
                                                                                "format": "int64",
                                                                                "type": "integer"
                                                                            },
                                                                            "path": {
                                                                                "description": "Path is the path relative to the mount point of the file to project the token into.",
                                                                                "type": "string"
                                                                            }
                                                                        },
                                                                        "required": [
                                                                            "path"
                                                                        ],
                                                                        "type": "object"
                                                                    }
                                                                },
                                                                "type": "object"
                                                            },
                                                            "type": "array"
                                                        }
                                                    },
                                                    "required": [
                                                        "sources"
                                                    ],
                                                    "type": "object"
                                                },
                                                "quobyte": {
                                                    "description": "Quobyte represents a Quobyte mount on the host that shares a pod's lifetime",
                                                    "properties": {
                                                        "group": {
                                                            "description": "Group to map volume access to Default is no group",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "ReadOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false.",
                                                            "type": "boolean"
                                                        },
                                                        "registry": {
                                                            "description": "Registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes",
                                                            "type": "string"
                                                        },
                                                        "tenant": {
                                                            "description": "Tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin",
                                                            "type": "string"
                                                        },
                                                        "user": {
                                                            "description": "User to map volume access to Defaults to serivceaccount user",
                                                            "type": "string"
                                                        },
                                                        "volume": {
                                                            "description": "Volume is a string that references an already created Quobyte volume by name.",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "registry",
                                                        "volume"
                                                    ],
                                                    "type": "object"
                                                },
                                                "rbd": {
                                                    "description": "RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd TODO: how do we prevent errors in the filesystem from compromising the machine",
                                                            "type": "string"
                                                        },
                                                        "image": {
                                                            "description": "The rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it",
                                                            "type": "string"
                                                        },
                                                        "keyring": {
                                                            "description": "Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it",
                                                            "type": "string"
                                                        },
                                                        "monitors": {
                                                            "description": "A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it",
                                                            "items": {
                                                                "type": "string"
                                                            },
                                                            "type": "array"
                                                        },
                                                        "pool": {
                                                            "description": "The rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it",
                                                            "type": "boolean"
                                                        },
                                                        "secretRef": {
                                                            "description": "SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it",
                                                            "properties": {
                                                                "name": {
                                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "user": {
                                                            "description": "The rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "image",
                                                        "monitors"
                                                    ],
                                                    "type": "object"
                                                },
                                                "scaleIO": {
                                                    "description": "ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Default is \"xfs\".",
                                                            "type": "string"
                                                        },
                                                        "gateway": {
                                                            "description": "The host address of the ScaleIO API Gateway.",
                                                            "type": "string"
                                                        },
                                                        "protectionDomain": {
                                                            "description": "The name of the ScaleIO Protection Domain for the configured storage.",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.",
                                                            "type": "boolean"
                                                        },
                                                        "secretRef": {
                                                            "description": "SecretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail.",
                                                            "properties": {
                                                                "name": {
                                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "sslEnabled": {
                                                            "description": "Flag to enable/disable SSL communication with Gateway, default false",
                                                            "type": "boolean"
                                                        },
                                                        "storageMode": {
                                                            "description": "Indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned.",
                                                            "type": "string"
                                                        },
                                                        "storagePool": {
                                                            "description": "The ScaleIO Storage Pool associated with the protection domain.",
                                                            "type": "string"
                                                        },
                                                        "system": {
                                                            "description": "The name of the storage system as configured in ScaleIO.",
                                                            "type": "string"
                                                        },
                                                        "volumeName": {
                                                            "description": "The name of a volume already created in the ScaleIO system that is associated with this volume source.",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "gateway",
                                                        "secretRef",
                                                        "system"
                                                    ],
                                                    "type": "object"
                                                },
                                                "secret": {
                                                    "description": "Secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret",
                                                    "properties": {
                                                        "defaultMode": {
                                                            "description": "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                            "format": "int32",
                                                            "type": "integer"
                                                        },
                                                        "items": {
                                                            "description": "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.",
                                                            "items": {
                                                                "description": "Maps a string key to a path within a volume.",
                                                                "properties": {
                                                                    "key": {
                                                                        "description": "The key to project.",
                                                                        "type": "string"
                                                                    },
                                                                    "mode": {
                                                                        "description": "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.",
                                                                        "format": "int32",
                                                                        "type": "integer"
                                                                    },
                                                                    "path": {
                                                                        "description": "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'.",
                                                                        "type": "string"
                                                                    }
                                                                },
                                                                "required": [
                                                                    "key",
                                                                    "path"
                                                                ],
                                                                "type": "object"
                                                            },
                                                            "type": "array"
                                                        },
                                                        "optional": {
                                                            "description": "Specify whether the Secret or its keys must be defined",
                                                            "type": "boolean"
                                                        },
                                                        "secretName": {
                                                            "description": "Name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "storageos": {
                                                    "description": "StorageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.",
                                                            "type": "string"
                                                        },
                                                        "readOnly": {
                                                            "description": "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.",
                                                            "type": "boolean"
                                                        },
                                                        "secretRef": {
                                                            "description": "SecretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted.",
                                                            "properties": {
                                                                "name": {
                                                                    "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                                                    "type": "string"
                                                                }
                                                            },
                                                            "type": "object"
                                                        },
                                                        "volumeName": {
                                                            "description": "VolumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace.",
                                                            "type": "string"
                                                        },
                                                        "volumeNamespace": {
                                                            "description": "VolumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \"default\" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created.",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "type": "object"
                                                },
                                                "vsphereVolume": {
                                                    "description": "VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine",
                                                    "properties": {
                                                        "fsType": {
                                                            "description": "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.",
                                                            "type": "string"
                                                        },
                                                        "storagePolicyID": {
                                                            "description": "Storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.",
                                                            "type": "string"
                                                        },
                                                        "storagePolicyName": {
                                                            "description": "Storage Policy Based Management (SPBM) profile name.",
                                                            "type": "string"
                                                        },
                                                        "volumePath": {
                                                            "description": "Path that identifies vSphere volume vmdk",
                                                            "type": "string"
                                                        }
                                                    },
                                                    "required": [
                                                        "volumePath"
                                                    ],
                                                    "type": "object"
                                                }
                                            },
                                            "required": [
                                                "name"
                                            ],
                                            "type": "object"
                                        },
                                        "type": "array"
                                    }
                                },
                                "type": "object"
                            },
                            "status": {
                                "description": "Most recent observed status of the ThanosRuler cluster. Read-only. Not included when requesting from the apiserver, only from the ThanosRuler Operator API itself. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status",
                                "properties": {
                                    "availableReplicas": {
                                        "description": "Total number of available pods (ready for at least minReadySeconds) targeted by this ThanosRuler deployment.",
                                        "format": "int32",
                                        "type": "integer"
                                    },
                                    "paused": {
                                        "description": "Represents whether any actions on the underlying managed objects are being performed. Only delete actions will be performed.",
                                        "type": "boolean"
                                    },
                                    "replicas": {
                                        "description": "Total number of non-terminated pods targeted by this ThanosRuler deployment (their labels match the selector).",
                                        "format": "int32",
                                        "type": "integer"
                                    },
                                    "unavailableReplicas": {
                                        "description": "Total number of unavailable pods targeted by this ThanosRuler deployment.",
                                        "format": "int32",
                                        "type": "integer"
                                    },
                                    "updatedReplicas": {
                                        "description": "Total number of non-terminated pods targeted by this ThanosRuler deployment that have the desired version spec.",
                                        "format": "int32",
                                        "type": "integer"
                                    }
                                },
                                "required": [
                                    "availableReplicas",
                                    "paused",
                                    "replicas",
                                    "unavailableReplicas",
                                    "updatedReplicas"
                                ],
                                "type": "object"
                            }
                        },
                        "required": [
                            "spec"
                        ],
                        "type": "object"
                    }
                },
                "served": true,
                "storage": true
            }
        ]
    }
}

}