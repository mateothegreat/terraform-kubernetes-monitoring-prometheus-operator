terraform {

    required_providers {

        kubernetes-alpha = {

            source  = "hashicorp/kubernetes-alpha"
            version = "0.3.2"

        }

        kubernetes = {

            source  = "hashicorp/kubernetes"
            version = "2.0.3"

        }

        aws = {

            source  = "hashicorp/aws"
            version = "3.35.0"

        }

    }

}
