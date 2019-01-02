#!/bin/sh
set +e
LINT_ACTION=$(sh -c 'find $ANSIBLE_ACTION_WORKING_DIR -name "*.yml" | xargs -r ansible-lint --force-color' 2>&1)
SUCCESS=$?
echo "$LINT_ACTION"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

exit $SUCCESS
