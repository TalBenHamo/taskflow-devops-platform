# Folder Explanation

This document describes the repository structure of the TaskFlow DevOps Platform.

```text
taskflow-devops-platform/
├── app/
├── ansible/
├── docs/
├── infra/
├── kubernetes/
├── monitoring/
├── scripts/
├── tests/
├── Dockerfile
├── compose.yaml
├── Jenkinsfile
└── README.md
```

## app/

Contains the Flask application source code, templates, and Python dependencies.

## ansible/

Contains the Ansible automation used to configure and deploy the AWS server.

It includes:

- Inventory
- Playbooks
- Variables
- Roles
- Linux configuration
- Application deployment

## docs/

Contains the project documentation.

It includes:

- Architecture
- Deployment explanation
- Folder explanation
- Challenges
- Lessons learned
- Future improvements
- Screenshots

## infra/

Contains the Terraform Infrastructure as Code configuration used to provision AWS resources.

## kubernetes/

Contains the Kubernetes deployment resources.

```text
kubernetes/
├── manifests/
└── helm-chart/
```

### manifests/

Contains the native Kubernetes YAML resources, including:

- Namespace
- ConfigMap
- Secret
- Deployments
- Services
- PersistentVolumeClaim
- Ingress

### helm-chart/

Contains the reusable Helm chart for TaskFlow.

## monitoring/

Contains the Prometheus and Grafana monitoring configuration.

It includes:

- kube-prometheus-stack values
- Monitoring documentation
- Exported Grafana dashboard

## scripts/

Contains Bash automation scripts used by the project.

The current health-check script validates:

- Docker availability
- Docker Compose services
- TaskFlow health endpoint

## tests/

Contains automated Pytest tests executed during the Jenkins pipeline.

## Dockerfile

Defines how the TaskFlow application Docker image is built.

## compose.yaml

Defines the local multi-container TaskFlow environment using Docker Compose.

The stack includes:

- TaskFlow
- PostgreSQL

## Jenkinsfile

Defines the Jenkins CI/CD pipeline as code.

The pipeline performs:

- Validation
- Build
- Automated testing
- Health checking
- Docker image tagging
- GHCR publishing
- AWS deployment using Ansible
- Deployment validation
- Cleanup

## README.md

Provides the main project overview and entry point to the detailed documentation.
