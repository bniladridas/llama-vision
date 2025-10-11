#!/bin/bash

git filter-branch -f --msg-filter '
msg="$GIT_COMMIT"
first_line=$(echo "$msg" | head -n1)
rest=$(echo "$msg" | tail -n +2)
processed_first=$(echo "$first_line" | tr "[:upper:]" "[:lower:]" | cut -c1-60)
echo "$processed_first"
if [[ -n "$rest" ]]; then
    echo ""
    echo "$rest"
fi
' -- --all