#!/bin/bash

git branch -D $(git branch | grep -E squash_ | sed "s/ //g")
