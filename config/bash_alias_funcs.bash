decode_base64_str() {
  local str="$1"
  echo -n "$str" | base64 -D
}

# liquidprompt
prompt_k8s_on() {
  export LP_ENABLE_KUBECONTEXT=1
}

prompt_k8s_off() {
  export LP_ENABLE_KUBECONTEXT=0
}

reload() {
  # Reload the login session configuration
  source "${HOME}/.bash_profile"
}

# vi:syntax=sh
