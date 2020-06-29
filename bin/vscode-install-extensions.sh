#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

pkglist=(
  aws-scripting-guy.cform
  DavidAnson.vscode-markdownlint
  foxundermoon.shell-format
  golang.Go
  hashicorp.terraform
  ms-azuretools.vscode-docker
  ms-kubernetes-tools.vscode-kubernetes-tools
  rarnoldmobile.todo-txt
  redhat.vscode-yaml
  searKing.preview-vscode
  shardulm94.trailing-spaces
  stkb.rewrap
  timonwong.shellcheck
  vscodevim.vim
  wholroyd.jinja
  yzhang.markdown-all-in-one
)

for extension in "${pkglist[@]}"; do
  code --install-extension "${extension}"
done

code --list-extensions
