# terraform-module-version-checker

This is a neat utility to keep track of your terraform module versions. If you are using terraform modules tagged with versions for updates relased frequently and eventually calling those versioned modules in your repository, this utility does a good job in tracking if any new version of the module is released and creates an issue in your current reposiotory for upgrading to the new version.

It also does not duplicate issue meaning if an issue has already been created for a module version upgrade, it does not recreate that issue again, however, if a new module version has been released after the issue has been created, it simply updates the issue with the new module version to be upgarded instead of creating another issue.

Few points to consider:

_The utility looks for module references in main.tf files only._

_The utility looks for a specific format in which the module is referenced in the main.tf file from the downstream module which is as below._ **Without the module being referenced with version ref as shown below will result in errors on running this action.**

```hcl
module "rg" {

  source  = "git::git@github.com:<repo_owner>/<repo_name>.git//services/resource-group?ref=v0.1.6"
  ## Example : source  = "git::git@github.com:persistentsystems/some-terraform-repo.git//services/resource-group/base/v1?ref=v0.1.6"

  context = local.context
  name = "${local.context.application_name}-${local.context.environment_name}"

}
```

## Example Usage

1. Set up a workflow yaml in your repository to run this action on a schedule say every day at a specific time as shown below

```bash
on:
  schedule:
    # * is a special character in YAML so you have to quote this string
    - cron:  '*/15 * * * *'
```

2. Checkout the repo that contains the modules for which module version has to be tracked

```bash
- name: Checkout Code
  uses: actions/checkout@v2
```

3. Run the action as below with the mandatory input variables.

```bash
- name: Terraform Module Version Checker
  uses: supratim-persistent/terraform-module-version-checker@v2
  with:
    REPO_OWNER: '<TO BE POPULATED>'
    REPO_NAME: '<TO BE POPULATED>'
    GITHUB_OAUTH_TOKEN: ${{ secrets.GIT_AUTH_TOKEN }}
```
