# Terraform Beginner Bootcamp 2023

## Semantic Versioning!!

This project will use semantic versioning for tagging
[semver.org](https://semver.org/)


The format:
- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Ex: `1.0.1`

## Install the Terraform CLI

### considerations with the terraform cli changes
The terraform CLI install instructions have changed due to gpg keyring changes. we needed to refer to the latest install CLI instrucitons
[Install the Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Considerations for Linux distribution
This project is built against Ubuntu. Must check you linux distribution.
https://beebom.com/how-check-linux-version/

Example of checking OS version
```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

## Refactoring bash scripts
The terraform CLI gpg deprication created a significant increase in the amount of code. so we created a bash script [.bin/install_terraform_cli](./bin/install_terraform_cli) to install the terraform cli
- keeps things tidy in the Gitpod task file ([.gitpod.yml](.gitpod.yml))
- better portability for other projects that need to install the CLI


## Shebang
A shebang tells the bash script what program will interpret the script
https://en.wikipedia.org/wiki/Shebang_(Unix)

For this project we used this format `#!/usr/bin/env bash`

### Execution considerations 
When executing the bash script we use `./` to execute the bash script

`./bin/install_terraform_cli`

`source ./bin/install_terraform_cli`

### Linux permissions considerations

We needed to change the linux permissions in order for the file to be executable at the user mode

`chmod u+x ./bin/install_terraform_cli`

Alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github lifecycle (Before, Init, command)

We need to be careful when using Init because it will not rerun if restarting an existing workspace. That is why the gitpod.yml file uses `before` instead of `init`

https://www.gitpod.io/docs/configure/workspaces/tasks

## Working with Env Vars
- Can list out all environment vars using the `env` command
- Can filter specific env vars using grep. ex: `env | grep AWS_`
- set using `export VAR_NAME=varValue`
- Remove env var using `unset VAR_NAME`
- Print env var with `echo $VAR_NAME`

#### Scoping Env Vars
In order to set Env Vars across all your terminal windows into the future, you need to set it in your `.bash_profile`

You can persist env vars across all GitPod workspaces in your account using `gp env VAR_NAME=VarValue`


### AWS CLI installation
AWS CLI is installed for this project. But you need to set Env Vars using the [./bin/install_aws_cli](./bin/install_aws_cli) bash script

[getting started install of AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

#### AWS CLI Env Vars
[here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

**REMEMBER** This command chekcs if our AWS crednetials are configured correctly `aws sts get-caller-identity`

If successful, you get the following json payload

```json
{
    "UserId": "EXAMPLEID",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/gitpod-tf-bootcamp"
}
```

We need to generate AWS CLI crednetials from IAM user to use the AWS CLI. I'm using `gitpod-tf-gitpod`

## Terraform basics

### tf registry
a colleciton of providers and modules in the tf registry [registry.terraform.io](https://registry.terraform.io/)

- **providers** is an interface to APIs to create tf resources - ex AWS and New Relic ... we used [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)
- **Modules** allow you to make large amonuts of tf code portable (modular)

### tf console
we can see a list of all the tf commands by typing `terraform`

- `terraform init` run at start of project to download tf binary providers (creates .terraform file) 
- `terraform plan` run to show what has changed in our infra sine the last time we ran the code
- `terraform apply` this command will run the the changes to be executed by tf.... Will ask for yes/no prompt.. this can be automated using `terraform apply --auto-approve`

## tf lock files
`.terrform.lock.hcl` contians versioning for providers and modules used in that project

## tf state files
contain info about the current state of your infra. do not commit this file! should be listed in .gitignore.. has PID in it
**Do not mess with terraform.tfstate and backup files. **

## tf directory 
`.terraform` directory has binaries of tf providers

### Terraform destroy
destorys resources you just created in this main.tf file... you can also use `--auto-approve`

You should run `terraform destroy` always when closing environment. 
^ confirm this by looking at `terraform.tfstate` and look at your resources

## Issues with tf cloud login and gitpod working together
issue running `terraform login`. Gitpod showed a bash view but it didn't work in Gitpod... WOrkaround is to manually generate a `credentials.tfrc.json` file at `touch /home/gitpod/.terraform.d/credentials.tfrc.json`

```json
{
    "credentials": {
        "app.terraform.io": {
            "token": "your tf cloud token"
        }
    }
}
```

#### automated login with `source ./bin/generate_trfc_creds`
necessary for working in gitpod
