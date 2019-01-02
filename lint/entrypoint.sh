#!/bin/sh
set -e
cd "${ANSIBLE_ACTION_WORKING_DIR:-.}"

set +e
LINT_ACTION=$(sh -c 'find . -name "*.yml" | xargs -r ansible-lint --force-color' 2>&1)
SUCCESS=$?
echo "$LINT_ACTION"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

exit $SUCCESS
