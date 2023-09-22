terraform {
  cloud {
    organization = "toms-org"

    workspaces {
      name = "terra-house-tom"
    }
  }

  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
     aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "aws" {

}


resource "random_string" "bucket_name" {
  length = 24
  lower  = true
  upper = false
  special = false
}

#this does the same thing as _result
#output "random_bucket_name_id" {
#  value = random_string.bucket_name.id
#}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

}
