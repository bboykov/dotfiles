#!/usr/bin/env bash

if [ -f "$HOME/.bashrc" ]; then
  source ~/.bashrc
  cd . || exit
fi

