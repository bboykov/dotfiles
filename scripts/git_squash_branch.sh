#!/usr/bin/env bash

set -e

current_branch=$(git rev-parse --abbrev-ref HEAD)
number_of_commits=$(git log master.."$current_branch" --pretty=oneline | wc -l | sed 's/ //g')
squash_branch=squash_${current_branch}_$(date +%Y%m%d%H%M%S)

export remote=origin
export master_branch=master
export current_branch
export number_of_commits
export squash_branch

# Create squash branch $squash_branch
git checkout -b "$squash_branch" &>/dev/null

# Squash commits
git reset --soft HEAD~"$number_of_commits" &>/dev/null
git commit -am "Squash commit of branch $current_branch" &>/dev/null
squash_commit=$(git rev-parse HEAD)
export squash_commit

# Return to branch
git checkout "$current_branch" &>/dev/null

# Print commit SHA
echo "###########################"
echo "Squashed into $squash_commit"
echo "###########################"
