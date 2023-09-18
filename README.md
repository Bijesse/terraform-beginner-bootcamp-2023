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