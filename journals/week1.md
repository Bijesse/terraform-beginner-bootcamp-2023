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

## Configuration drift

### TF import
If you lose your tfstate file, you tear down cloud infra manually and then check tf providers documentation to see who supports import

[Terraform import](https://developer.hashicorp.com/terraform/language/import)
[S3 bucket import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

`tf import aws_s3_bucket.example`

## Fix manual configuration
if a bucket is deleted manually via clickops, we can run tf plan again to put our infra back into the expected state

## Fix using tf refresh

`tf apply -refresh-only --auto-approve`

## Tf modules

### tf module structure
place modules in a `modules` dir

### Passing input vars
the source (below) needs to be declared in a variables.tf file

### module sources
[module sources](https://developer.hashicorp.com/terraform/language/modules/sources)

Using the source, we can import the module localy or from github
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

## Working with files in tf

### fileexists
tf function that check if the file exists

ex:
```bash
variable "index_html_filepath" {
  type = string
  description = "The file path to the index.html file."
  validation {
    condition = fileexists(var.index_html_filepath)
    error_message = "The index.html file must be a valid file path."
  }
}
```

### Path var
In tf there is a path var that allows us to reference local paths:
  - path.module - get path for current module
  - path.root
[Special path var](https://developer.hashicorp.com/terraform/language/expressions/references)

ex path var
```bash
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index_html"

  etag = "${path.root}/public/index_html"
}
```

[etagmd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)
Creates a change in the tfstate file based on a content change... Otherwise tf plan only check for infra changes

## Terraform data sources
[Data sources](https://developer.hashicorp.com/terraform/language/data-sources)

### TF locals
Allows us to source data from cloud resources. refernce without importing 
https://developer.hashicorp.com/terraform/language/values/locals

```bash
locals {
    s3_origin_id = "MyS3Origin"
}
``` 

### JSONencode
jsonencode encodes a given value to a string using JSON syntax... we used it to create the json policy in the hcl
https://developer.hashicorp.com/terraform/language/functions/jsonencode

```bash
> jsonencode({"hello"="world"})
{"hello":"world"}
```

### Changing lifecycle resources
[meta args lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### tf data
[tf_data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)
data values and input cars that don't get affected by tf plan because they use `replace_triggered_by`

## Provisioners
Provisioners allow to execute commands on compute instances ... ex: AWS cli command.. Hasicrop doesn't like them, they prefer we use ansible
[provisioners as a last resort](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### local-exec
executes command on machine running the tf commands (plan & apply)

```bash
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

### remote-exec
executes command on machine on machine you target. usually need to ssh into it

```bash
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

## For Each
[for each](https://developer.hashicorp.com/terraform/language/expressions/for)
Allows us to itterate over complex data types. useful for reducing tf code when creating multiple cloud resources
`[for s in var.list : upper(s)]`

