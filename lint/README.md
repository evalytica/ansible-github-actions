# Ansible Lint Action

Runs `ansible-lint` against all playbooks in the path defined by the `ANSIBLE_ACTION_WORKING_DIR` environment variable.

## Environment Variables

`ANSIBLE_ACTION_WORKING_DIR`: The subdirectory of the repository that contains Ansible playbooks. (*Default*: `"."`)

`ANSIBLE_VAULT_PASSWORD`: The Ansible Vault password to use to decrypt Vaulted variables.
