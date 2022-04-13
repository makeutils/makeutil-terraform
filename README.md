# makeutil-terraform

Terraform makeutils proof of concept module for demonstrating dynamic includes using a tag

## Importing using bootstrap

```make
include $(call .include,terraform,0.0.1)
```

## Input and configuration variables

There is an intrinsic `stack` variable reflecting the name of the current select terraform workspace.

| name | default | description |
| --- | --- | --- |
| `TERRAFORM` | `terraform` | the command to use for invoking terraform |
| `VARFILES` | `-var-file=$(stack).tfvars` | var var files argument |

## available targets

| name | description |
| --- | --- |
| `info` | shows current workspace name and terraform version in use |
| `init` | runs init terraform sub command |
| `clean` | removes `.terraform` sub folder |
| `reinit` | `clean` + `init` goals |
| `switch` | changes to another environment, creating it if necessary, requires you to specify the `stack` parameter. Use `select.*` for more comfort  |
| `select.*` | dynamic targets using `.tfvars` files matching the `.*-[0-9]{-2}\.tfvars` |
| `validate` | runs validate terraform sub command using the correct var files |
| `get` | runs validate terraform sub command |
| `plan` | runs plan terraform sub command using the correct var files, plan stored in `tfplan` file |
| `apply` | runs apply terraform sub command using the plan stored in the file `tfplan` |
| `destroy` | runs destroy terraform sub command using the correct var files |
| `refresh` | runs refresh terraform sub command using the correct var files |

## Using with AWS

If you are interacting with AWS then you may want to include the following exports at the top of you `Makefile`.

```make
export AWS_PROFILE=profile_name
export AWS_SDK_LOAD_CONFIG=1
```
