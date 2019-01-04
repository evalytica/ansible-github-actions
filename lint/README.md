# Ansible Lint Action

Runs `ansible-lint` against all playbooks in the path defined by the `ANSIBLE_ACTION_WORKING_DIR` environment variable.  The action succeeds if there are no linting suggestions.

## Usage

To use the `ansible-lint` action, add it to your workflow file.

```
action "ansible-lint" {
  # Replace <latest tag> with the latest tag from
  # https://github.com/hashicorp/terraform-github-actions/releases.
  uses = "evalytica/ansible-github-actions/lint@<latest tag>"

  # See Environment Variables below for details.
  env = {
    ANSIBLE_ACTION_WORKING_DIR = "."
  }

  # We need the GitHub token to be able to comment back on the pull request.  
  secrets = ["GITHUB_TOKEN"]
}
```

`ansible-lint` can be tuned using a [configuration file](https://docs.ansible.com/ansible-lint/configuring/configuring.html#configuration-file) located in the same directory as the playbooks.

## Environment Variables

`ANSIBLE_ACTION_WORKING_DIR`: The subdirectory of the repository that contains Ansible playbooks. (*Default*: `"."`)

`ANSIBLE_ACTION_COMMENT`: Set to `"false"` to disable commenting back on pull request with the linting suggestions on all playbooks and roles. (*Default*: `"true"`)

`ANSIBLE_VAULT_PASSWORD`: The Ansible Vault password to use to decrypt Vaulted variables.

## Secrets

`GITHUB_TOKEN`: Required for posting a comment back to the pull request if `ansible-lint` fails.  If you have set `TF_ACTION_COMMENT` = `"false"`, then `GITHUB_TOKEN` is not required.

## Acknowledgement

This action uses methods and documentation adopted from the [Terraform Fmt GitHub Action](https://github.com/hashicorp/terraform-github-actions/tree/master/fmt).
