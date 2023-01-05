variable "access_key" {
description = "AWS Access key"
}

variable "secret_key" {
description = "AWS Secret Key"
}

variable "region" {
description = "AWS region"
default = "us-east-2"
}

variable "domain_name" {
description = "Domain Name for the cloud resume challange"
default = "jasontaylor.info"
}

variable "bucket_name" {
description = "Bucket Name for the cloud resume challange"
default = "jasontaylor.info"
}

