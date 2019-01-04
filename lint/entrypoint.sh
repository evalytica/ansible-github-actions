#!/bin/sh
# check to see if there are any linting suggestions
set -e
cd "${ANSIBLE_ACTION_WORKING_DIR:-.}"

set +e
LINT_ACTION=$(sh -c 'find . -maxdepth 1 -name "*.yml" | xargs -r ansible-lint --force-color' 2>&1)
SUCCESS=$?
echo "$LINT_ACTION"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

# see if a comment on the PR is required - if not, exit
if [ "$ANSIBLE_ACTION_COMMENT" = "1" ] || [ "$ANSIBLE_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

# there are suggestions -- get list of playbooks
set -e
cd "${ANSIBLE_ACTION_WORKING_DIR:-.}"

set +e
LINT_FILES=$(sh -c 'find . -maxdepth 1 -name "*.yml"' 2>&1)
echo "$LINT_FILES"
set -e

# iterate through each playbook with linting suggestions and build up a comment
FMT_OUTPUT=""
for file in $LINT_FILES; do
LINT_OUTPUT=$(ansible-lint --force-color "$file")
if [ ! -z "$LINT_OUTPUT" -a "$LINT_OUTPUT" != " " ]; then
FMT_OUTPUT="$FMT_OUTPUT
<details><summary><code>$file</code></summary>
\`\`\`diff
$LINT_OUTPUT
\`\`\`
</details>
"
fi
done

COMMENT="#### \`ansible-lint\` Failed
$FMT_OUTPUT
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
echo "$PAYLOAD"
COMMENTS_URL=$(cat $GITHUB_EVENT_PATH | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS
