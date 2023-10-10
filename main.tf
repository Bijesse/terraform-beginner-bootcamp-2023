terraform {
    required_providers {
      terratowns = {
        source = "local.providers/local/terratowns"
        version = "1.0.0"
      }
    }


  cloud {
    organization = "toms-org"

    workspaces {
      name = "terra-house-tom"
    }
  }


}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token= var.terratowns_access_token
}

module "home_contra_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.contra.public_path
  content_version = var.contra.content_version
}

resource "terratowns_home" "home_contra" {
  name = "Contra home"
  description = <<DESCRIPTION
A home dedicated to Contra
DESCRIPTION
  domain_name = module.home_contra_hosting.domain_name
  #domain_name = "1fdq3gx.cloudfront.net"
  town = "missingo"
  content_version = var.contra.content_version
}

module "home_zelda_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.zelda.public_path
  content_version = var.zelda.content_version
}

resource "terratowns_home" "home_zelda" {
  name = "ocarina of time"
  description = <<DESCRIPTION
Quite possibly the best game ever made
DESCRIPTION
  domain_name = module.home_zelda_hosting.domain_name
  #domain_name = "1fdq3gx.cloudfront.net"
  town = "gamers-grotto"
  content_version = var.zelda.content_version
}