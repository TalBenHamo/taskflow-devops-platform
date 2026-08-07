# Deployment Explanation

TaskFlow demonstrates a complete end-to-end DevOps deployment pipeline.

The project supports two deployment models:

- AWS deployment using Docker Compose and Ansible.
- Kubernetes deployment using native manifests and Helm.

The same Docker image is used across both environments and is stored in GitHub Container Registry (GHCR).

---

## Kubernetes Secret Configuration

The repository contains an example Kubernetes Secret file:

```text
kubernetes/manifests/secret.example.yaml
```

Before deploying the raw Kubernetes manifests, create a local Secret file:

```bash
cp kubernetes/manifests/secret.example.yaml \
   kubernetes/manifests/secret.yaml
```

Update the local `secret.yaml` with the required database password.

The local `secret.yaml` file is excluded from Git to prevent credentials from being committed to the repository.

---

# CI/CD Pipeline

The Jenkins pipeline automates the CI/CD lifecycle for the AWS deployment path.

Pipeline stages:

1. Checkout source code
2. Validate Python syntax
3. Validate Ansible playbook
4. Build Docker image
5. Start temporary Docker Compose environment
6. Wait for PostgreSQL readiness
7. Run automated Pytest tests
8. Verify the health endpoint
9. Tag the Docker image
10. Push image to GitHub Container Registry
11. Deploy to AWS using Ansible
12. Validate deployment health
13. Clean up temporary resources

The pipeline is triggered automatically by repository changes using Jenkins SCM polling.

---

## Jenkins Trigger

The Jenkins job tracks the `main` branch.

Because Jenkins runs inside a private network, GitHub cannot directly reach the Jenkins webhook endpoint.

SCM polling is therefore used to detect repository changes and automatically trigger the pipeline.

The polling schedule is configured to check for repository changes approximately every two minutes.

The trigger was validated successfully, with Jenkins builds starting automatically with:

```text
Started by an SCM change
```
---

# Source Control

Development follows a feature branch workflow.

Typical process:

```text
feature branch
      |
Commit Changes
      |
Push to GitHub
      |
Jenkins CI/CD
      |
Validation
      |
Merge into main
```

Each feature is developed independently before being merged into the main branch.

---

# Local Development

Developers can start the complete environment locally using Docker Compose.

```bash
docker compose up --build -d
```

The application becomes available on:

```text
http://localhost:5000
```

---

# AWS Deployment

Infrastructure is provisioned using Terraform.

Application deployment is automated using Ansible.

Deployment workflow:

```text
Terraform
      |
AWS Infrastructure
      |
Ansible
      |
Docker Compose
      |
TaskFlow
```

Ansible automatically:

- Installs Docker
- Installs Docker Compose
- Installs Git
- Installs Python
- Creates the deployment user
- Configures SSH
- Clones the repository
- Starts Docker Compose
- Verifies the health endpoint

The playbook is idempotent and completes with:

```text
changed=0
failed=0
```

on subsequent executions.

---

# Kubernetes Deployment

TaskFlow is deployed to Kubernetes using production-ready manifests.

The deployment includes:

- Namespace
- ConfigMap
- Secret
- PersistentVolumeClaim
- PostgreSQL
- Multi-replica TaskFlow Deployment
- Service
- Ingress
- Readiness Probe
- Liveness Probe
- Rolling Updates
- Rollback
- Resource Requests and Limits

The application is exposed through Kubernetes Ingress.

---

# Helm Deployment

The Kubernetes manifests were converted into a reusable Helm chart.

The chart supports:

- Configurable values
- PostgreSQL
- TaskFlow
- ConfigMap
- Secret
- Services
- Persistent Storage
- Ingress
- Upgrade
- Rollback

The Helm chart was validated using:

```bash
helm lint
helm template
helm install
helm upgrade
helm rollback
```

Both upgrade and rollback operations completed successfully without application downtime.

---

# Monitoring

The Kubernetes environment is monitored using the Prometheus Community Stack.

Monitoring components:

- Prometheus
- Grafana
- Prometheus Operator
- kube-state-metrics
- Node Exporter

The monitoring platform provides visibility into:

- Pod health
- CPU usage
- Memory usage
- Kubernetes resources

Grafana dashboards were created to visualize TaskFlow resource consumption.

---

# Linux Security

The local development environment follows Linux security best practices.

Current configuration:

- Regular development user
- sudo for administrative operations
- Dedicated Jenkins service account
- Docker group permissions for Jenkins
- SSH authentication for Git operations

The AWS deployment additionally implements:

- Dedicated deployment user
- Disabled root SSH login
- Disabled SSH password authentication
- Automated server configuration using Ansible

---

# Deployment Summary

TaskFlow demonstrates a complete DevOps workflow covering:

- Source Control
- Continuous Integration
- Continuous Delivery
- Infrastructure as Code
- Configuration Management
- Containerization
- Kubernetes Orchestration
- Helm Packaging
- Monitoring
- Production Validation
