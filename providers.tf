terraform {
 /*
  cloud {
    organization = "toms-org"

    workspaces {
      name = "terra-house-tom"
    }
  }
*/
  required_providers {

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