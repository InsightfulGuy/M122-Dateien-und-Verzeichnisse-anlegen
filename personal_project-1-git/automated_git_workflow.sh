#!/bin/bash

# config
REPO_DIR="/path/to/my/repo" # hypothetical path to my repository for usage
BRANCH="main" # to branch name
COMMIT_MESSAGE="Automated commit: $(date)"
REMOTE="origin"

# repo directory change
cd "$REPO_DIR" || { echo "Error: Couldn't find Repository Directory."; exit 1; }

if [[ -n $(git status -s) ]]; then
    echo "CHanges found. Applying updates..."

    # changes to staging 
    git add .

    # commit message
    git commit -m "$COMMIT_MESSAGE"

    # push to branch
    git push "$REMOTE" "$BRANCH"

    echo "Changes successfully pushed."
else
    echo "No changes found. "
fi

echo "Git-Workflow abgeschlossen."
