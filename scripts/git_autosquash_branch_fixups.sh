#!/bin/bash

export current_branch=$(git rev-parse --abbrev-ref HEAD)
export number_of_commits=$(git log master..$current_branch --pretty=oneline | wc -l | sed 's/ //g')

git rebase -i HEAD~$number_of_commits --autosquash
