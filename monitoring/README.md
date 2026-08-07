# TaskFlow Monitoring

TaskFlow uses the Prometheus Community kube-prometheus-stack Helm chart.

## Components

- Prometheus
- Grafana
- Prometheus Operator
- kube-state-metrics
- Node Exporter

## Installation

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade --install monitoring \
  prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  -f monitoring/values.yaml \
  --timeout 15m

## Validation

kubectl get pods -n monitoring

Prometheus health:

kubectl port-forward -n monitoring \
  svc/monitoring-kube-prometheus-prometheus \
  9091:9090

curl http://127.0.0.1:9091/-/healthy

Example PromQL:

container_memory_working_set_bytes{namespace="taskflow"}

rate(container_cpu_usage_seconds_total{namespace="taskflow"}[5m])

Grafana was validated by querying TaskFlow namespace metrics collected by Prometheus.
