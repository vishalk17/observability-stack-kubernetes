#!/bin/bash

# script by github.com/vishalk17
# contact t.me/vishalk17

# Error handling
set -e

# Set environment variables
kubectl="kubectl"
kubectl="microk8s kubectl"  # if not exit then pick this
helm="helm"
helm="microk8s helm3"   # if not exit then pick this
smtp_pass="mypass123"

# set namespace
namespace="observability"

# Add Helm repos
$helm repo add kube-prom-stack https://prometheus-community.github.io/helm-charts
$helm repo add grafana https://grafana.github.io/helm-charts

# Update Helm repos
$helm repo update

# Get internal IP addresses of all nodes
NODE_ENDPOINTS=$($kubectl get nodes -o jsonpath={.items[*].status.addresses[?\(@.type==\"InternalIP\"\)].address})
NODE_ENDPOINTS=$(echo $NODE_ENDPOINTS | tr ' ' ',')  # workround for single node

# Configure Grafana data sources
helm_opts=(
  "--set=grafana.additionalDataSources[0].name=loki"
  "--set=grafana.additionalDataSources[0].type=loki"
  "--set=grafana.additionalDataSources[0].url=http://loki.observability.svc.cluster.local:3100"
  "--set=grafana.additionalDataSources[1].name=tempo"
  "--set=grafana.additionalDataSources[1].type=tempo"
  "--set=grafana.additionalDataSources[1].url=http://tempo.observability.svc.cluster.local:3100"
)

# Install kube-prom-stack
$helm upgrade --install kube-prom-stack kube-prom-stack/kube-prometheus-stack \
  --create-namespace --namespace $namespace \
  "${helm_opts[@]}" \
  -f grafana-values.yaml

# Install loki
#$helm upgrade --install loki loki-tempo/loki-stack \
#  --create-namespace --namespace $namespace \
#  --set="grafana.sidecar.datasources.enabled=false"

# Install Tempo
#$helm upgrade --install tempo grafana/tempo \
#  --create-namespace --namespace $namespace

# fixing smtp credential
sleep 15
echo ""
echo "fixing smtp for grafana"
echo ""
echo "applying patch for pass of smtp. make sure you have edited this script to include"
echo ""

$kubectl get cm kube-prom-stack-grafana -n $namespace -o yaml | \
  sed -e '/^ *password *=/d' \
      -e "/^ *user *= */a \ \ \ \ password = $smtp_pass" | \
  $kubectl apply -f -

echo ""

# This command ensures that if the password line already exists, 
# it will be deleted first and then added below the user line. 
# If it doesn't exist, it will simply be added below the user line.

echo "Restart the deployment of grafana"
echo ""
$kubectl rollout restart deployment  kube-prom-stack-grafana -n $namespace
echo ""
echo "fixed smtp"

echo "====================================="
echo " grafana username: admin"
echo " grafana pass: prom-operator"
echo "====================================="
