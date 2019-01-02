#!/bin/sh
set +e
LINT_ACTION=$(sh -c 'find $ANSIBLE_ACTION_WORKING_DIR -name "*.yml" | xargs -r ansible-lint --force-color' 2>&1)
SUCCESS=$?
echo "$LINT_ACTION"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

COMMENT="#### \`ansible-lint\` Failed
$LINT_ACTION
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS
