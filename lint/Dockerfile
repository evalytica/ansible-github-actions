FROM yokogawa/ansible-lint:latest

LABEL "com.github.actions.name"="ansible-lint"
LABEL "com.github.actions.description"="Check Ansible playbooks for practices and behavior that could potentially be improved."
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/evalytica/ansible-github-actions"
LABEL "homepage"="https://github.com/evalytica/ansible-github-actions"
LABEL "maintainer"="Alex Harden <alex.harden@veradigmhealth.com>"

RUN apk --no-cache add jq

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
