# Prometheus operator instrumented by Terraform

### Set up the aws provider (optional)

```hcl-terraform

#
# Retrieve authentication for kubernetes from aws.
#
provider "aws" {

    profile = var.aws_profile
    region  = var.aws_region

}

#
# Get kubernetes cluster info.
#
data "aws_eks_cluster" "cluster" {

    name = var.cluster_name

}

#
# Retrieve authentication for kubernetes from aws.
#
data "aws_eks_cluster_auth" "cluster" {

    name = var.cluster_name

}
```

In this example the outputs of `aws_eks_cluster` and `aws_eks_cluster_auth` are consumed
below when we set up the kubrernetes providers.

### Set up the kubernetes provider

```hcl-terraform
provider "kubernetes" {

    host     = var.host
    token    = var.token
    insecure = var.insecure

}
```

### Set up the kubernetes-alpha provider

This is used because the module itself depends on the ability to
manage custom CRD objects.

```hcl-terraform
provider "kubernetes-alpha" {

    host     = var.host
    token    = var.token
    insecure = var.insecure

}
```

### Set up the module

This is a sampled down example below
(see https://registry.terraform.io/modules/mateothegreat/monitoring-prometheus-operator/kubernetes/latest?tab=inputs
for all the inputs).

```hcl-terraform
module "monitoring-prometheus-operator" {

    source  = "mateothegreat/monitoring-prometheus-operator/kubernetes"
    version = "<insert latest version>"

    operator_namespace = "test-operator-1"

}
```
