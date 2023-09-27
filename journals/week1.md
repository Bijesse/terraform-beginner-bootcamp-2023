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

## TF vars
[Terraform input variables](https://developer.hashicorp.com/terraform/language/values/variables)

in tf we can set two types of vars
    - env vars - normally set in tfvars file
    - tf vars - normally set in bash terminal (AWS creds are an ex)

### var flag
use `-var` flag to set or override varibale in tfvars file `tf -var user_uuid="my_uuid`

### var file flag
 var-file flag is a powerful way to pass variables to Terraform. useful for PII
`terraform apply -var-file="variables.tfvars"`

### terraform.tfvars
deafult file to load tf vars in bulk

### auto.tfvars
special type of variable file in Terraform that is automatically loaded by Terraform when it is present in the current directory.

## order of tf vars
Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

Environment variables
1. terraform.tfvars file
2. terraform.tfvars.json file
3. Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames
4. Any -var and -var-file options on the command line, in the order they are provided
5. Variable defaults