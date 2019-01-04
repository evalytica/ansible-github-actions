# Ansible GitHub Actions

This provides a GitHub Action for linting Ansible code.  Other actions may be added in the future.

## Getting Started

Create a GitHub Action workflow in a private repository hosting Ansible playbooks with the following code in the default workflow:

```
workflow "Ansible" {
  resolves = "ansible-lint"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "ansible-lint" {
  uses = "evalytica/ansible-github-actions/lint@0.2.0"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    ANSIBLE_ACTION_WORKING_DIR = "."
  }
}
```

This Actions workflow will run `ansible-lint` against all playbooks in the root of the repository whenever a pull request is opened.  Edit the GitHub Action environment variable `ANSIBLE_ACTION_WORKING_DIR` with the path to the subdirectory that contains the Ansible playbooks to lint.

Add a GitHub Secret named `ANSIBLE_VAULT_PASSWORD` to the action with the Ansible Vault password required to decrypt Vaulted variables in the targeted playbooks.

## Actions

### Lint Action

Runs `ansible-lint` against all playbooks.  `ansible-lint` can be tuned using a [configuration file](https://docs.ansible.com/ansible-lint/configuring/configuring.html#configuration-file) located in the same directory as the playbooks.
