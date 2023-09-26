# Terraform Bootcamp Week 1

## Root module structure
[Standard module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

our structure will be:

PROJECT_ROOT
    ├── variables.tf # stores input vars
    ├── output.tf # stores out output
    ├── main.tf # everything else
    ├── providers.tf # defines the required providers
    └── terraform.tfvars # the data of vars we want to load in the tf project
