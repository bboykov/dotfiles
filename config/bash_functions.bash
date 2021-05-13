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

kind_create_local_kind_cluster() {
  kind create cluster \
    --kubeconfig ~/.kube/config \
    --config $HOME/dotfiles/config/k8s/local-kind-cluster.yaml \
    --wait 5m \
    --name local-kind-cluster
}

kind_delete_local_kind_cluster() {
  kind delete cluster --name local-kind-cluster
}

kind_create_local_multi_node_kind_cluster() {
  kind create cluster \
    --kubeconfig ~/.kube/config \
    --config $HOME/dotfiles/config/k8s/local-multi-node-kind-cluster.yaml \
    --wait 5m \
    --name local-multi-node-kind-cluster
}

kind_delete_local_multi_node_kind_cluster() {
  kind delete cluster --name local-multi-node-kind-cluster
}

k3d_create_local_k3d_cluster() {
  export KUBECONFIG="$HOME/.kube/config"
  k3d cluster create --config "${HOME}/dotfiles/config/k8s/local-k3d-cluster.yaml"
}

k3d_delete_local_k3d_cluster() {
  export KUBECONFIG="$HOME/.kube/config"
  k3d cluster delete local-k3d-cluster
}

k3d_create_local_multi_node_k3d_cluster() {
  export KUBECONFIG="$HOME/.kube/config"
  k3d cluster create --config "${HOME}/dotfiles/config/k8s/local-multi-node-k3d-cluster.yaml"
}

k3d_delete_local_multi_node_k3d_cluster() {
  export KUBECONFIG="$HOME/.kube/config"
  k3d cluster delete local-multi-node-k3d-cluster
}

