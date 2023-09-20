terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 8
  special          = false
}

#this does the same thing as _result
#output "random_bucket_name_id" {
#  value = random_string.bucket_name.id
#}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}
