# GitLab Aliases
alias ci_commit_ref_slug="echo \$(git rev-parse --abbrev-ref HEAD | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g; s/^-//; s/-$//; s/(.{1,63}).*/\1/')"
