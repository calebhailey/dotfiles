# GitLab Aliases
alias ci_commit_ref_slug="echo \$(git rev-parse --abbrev-ref HEAD | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g; s/^-//; s/-$//; s/(.{1,63}).*/\1/')"
alias gitlab_ci_jobs="glab ci get --with-job-details"
alias gitlab_ci_trace="glab ci trace --pipeline-id"

# Usage:
#   glabciwatch
#
# Requirements:
#   - glab
#   - jq
#
# Behavior:
#   - Fetches pipelines with: glab ci get --output json
#   - Filters to running pipelines
#   - If exactly one running pipeline exists, traces it immediately
#   - If multiple exist, shows a numbered menu using commit.title and prompts for selection

glabciwatch() {
    local json
    local running
    local count
    local selection
    local pipeline_id

    if ! command -v glab >/dev/null 2>&1; then
        echo "error: glab is not installed" >&2
        return 1
    fi

    if ! command -v jq >/dev/null 2>&1; then
        echo "error: jq is not installed" >&2
        return 1
    fi

    if ! json="$(glab ci get --output json)"; then
        echo "error: failed to run: glab ci get --output json" >&2
        return 1
    fi

    # Normalize the output into a JSON array, then keep only running pipelines.
    # This handles:
    #   - a single pipeline object
    #   - an array of pipeline objects
    #   - newline-delimited JSON objects
    if ! running="$(
        printf '%s\n' "$json" | jq -s '
            if length == 1 then
                if (.[0] | type) == "array" then .[0]
                elif (.[0] | type) == "object" then [.[0]]
                else []
                end
            else
                map(select(type == "object"))
            end
            | map(select(.status == "running"))
        '
    )"; then
        echo "error: failed to parse glab JSON output" >&2
        return 1
    fi

    count="$(printf '%s\n' "$running" | jq 'length')"

    if [ "$count" -eq 0 ]; then
        echo "No running pipelines found."
        return 0
    fi

    if [ "$count" -eq 1 ]; then
        pipeline_id="$(printf '%s\n' "$running" | jq -r '.[0].id')"
        exec glab ci trace --pipeline-id "$pipeline_id"
    fi

    echo "Running pipelines:"
    printf '%s\n' "$running" | jq -r '
        to_entries[]
        | "\(.key + 1). \(.value.id) \(.value.jobs[0].commit.title // .value.sha // "(no title)")"
    '

    while true; do
        printf 'Select a pipeline [1-%s]: ' "$count"
        IFS= read -r selection

        case "$selection" in
            ''|*[!0-9]*)
                echo "Invalid selection."
                ;;
            *)
                if [ "$selection" -lt 1 ] || [ "$selection" -gt "$count" ]; then
                    echo "Invalid selection."
                    continue
                fi

                pipeline_id="$(
                    printf '%s\n' "$running" \
                    | jq -r --argjson i "$((selection - 1))" '.[ $i ].id'
                )"

                exec glab ci trace --pipeline-id "$pipeline_id"
                ;;
        esac
    done
}
