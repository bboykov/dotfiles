#!/usr/bin/env bash


# Strict Mode - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

SCRIPT_NAME=$(basename "$0")
SCRIPT_WORKDIR=$(mktemp -d /tmp/"${SCRIPT_NAME}".XXXXXXXXXXXXX)
K8S_CLUSTER_NAME=local-multi-node-kind-cluster
CONFIG_PATH_K8S_CLUSTER_NAME="${HOME}/dotfiles/config/k8s/local-multi-node-kind-cluster.yaml"

create_kind_cluster(){
  kind create cluster \
    --kubeconfig ~/.kube/config \
    --config "${CONFIG_PATH_K8S_CLUSTER_NAME}" \
    --wait 5m \
    --name "${K8S_CLUSTER_NAME}"

  kubectl cluster-info --context "kind-${K8S_CLUSTER_NAME}" \
    --kubeconfig ~/.kube/config

}

install_metric_server() {
# Ref: https://gist.github.com/sanketsudake/a089e691286bf2189bfedf295222bd43
  echo " 🧩 Install Metric server"

  METRIC_SERVER_PATH="${SCRIPT_WORKDIR}/metric-server-kustomize"
  if [ ! -d "${METRIC_SERVER_PATH}" ]; then
    mkdir -p "${METRIC_SERVER_PATH}"
  fi

  cat << EOF > "${METRIC_SERVER_PATH}/kustomization.yml"
resources:
  - https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.7.1/components.yaml

patches:
  - patch: |-
      - op: add
        path: /spec/template/spec/containers/0/args/-
        value: --kubelet-insecure-tls
    target:
      version: v1
      kind: Deployment
      name: metrics-server
      namespace: kube-system

EOF

  kubectl apply -k "${METRIC_SERVER_PATH}"
}

install_ingress_nginx(){
  echo " 🧩 Install Nginx Ingress"

  ### https://kind.sigs.k8s.io/docs/user/ingress/
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

  kubectl wait --namespace ingress-nginx \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/component=controller \
    --timeout=90s
}

create_cluster(){

  create_kind_cluster "${CONFIG_PATH_K8S_CLUSTER_NAME}" "${K8S_CLUSTER_NAME}"

  # kubie ctx "kind-${K8S_CLUSTER_NAME}"
  # kubectl cluster-info --context "kind-${K8S_CLUSTER_NAME}" --kubeconfig "${HOME}/.kube/config"
  kubectl config use-context "kind-${K8S_CLUSTER_NAME}"

  install_metric_server
  install_ingress_nginx

}

delete_cluster(){
  kind delete cluster --name "${K8S_CLUSTER_NAME}"
}

main() {
  if [ $# -ne 1 ]; then
    echo "The script takes one argument:"
    echo "create    - To create a cluster"
    echo "delete    - To delete a cluster"
  fi

  case "${1}" in
    create)
      create_cluster
      ;;
    delete)
      delete_cluster
      ;;
    *)
      echo "Unknown command:"
      echo "$@"
      echo "Abort!"
      exit 1
      ;;
  esac
}

main "$@"
