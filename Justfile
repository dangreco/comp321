[private]
default:
    @just --list

test:
    #!/usr/bin/env bash
    set -euo pipefail
    status=0
    find . -name "problem.json" -type f | while read -r problem; do
        dir=$(dirname "$problem")
        par=$(basename "$(dirname "$dir")")
        name=$(jq -r '.name' "$problem")
        echo "= $par :: $name"

        if (cd "$dir" && just test 2>&1) | sed 's/^/\t/'; then
            : # ok
        else
            exit 1
        fi
    done
