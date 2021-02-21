#!/usr/bin/env bash

base64_decode_str() {
  local str="$1"
  echo -n "$str" | base64-decode
}

# liquidprompt
prompt_k8s_on() {
  export LP_ENABLE_KUBECONTEXT=1
}

prompt_k8s_off() {
  export LP_ENABLE_KUBECONTEXT=0
}

# Reload the login session configuration
reload() {
  source "${HOME}/.bash_profile"
}
