# TaskFlow Architecture

TaskFlow is an end-to-end DevOps platform demonstrating modern application delivery using both traditional virtual machine deployment and Kubernetes orchestration.

The project supports two deployment paths while using the same Flask application and Docker image stored in GitHub Container Registry (GHCR).

---

## AWS Deployment

The AWS deployment demonstrates a traditional infrastructure approach using Infrastructure as Code and Configuration Management.

Deployment workflow:

```text
Developer
    |
GitHub Repository
    |
Jenkins CI/CD
    |
Docker Build
    |
Push Image to GHCR
    |
Ansible
    |
AWS EC2
    |
Docker Compose
    |
TaskFlow + PostgreSQL
```

Main technologies:

- Jenkins CI/CD
- Docker
- GitHub Container Registry (GHCR)
- Terraform
- AWS EC2
- Ansible
- Docker Compose

---

## Kubernetes Deployment

The Kubernetes deployment demonstrates a production-style container orchestration environment.

Deployment options:

- Native Kubernetes Manifests
- Helm Chart

The deployment includes:

- Namespace isolation
- ConfigMap
- Secret
- Persistent Volume Claim (PVC)
- PostgreSQL
- Multi-replica TaskFlow Deployment
- Kubernetes Service
- Ingress
- Readiness Probe
- Liveness Probe
- Rolling Updates
- Rollback
- Resource Requests and Limits

---

## Monitoring

The Kubernetes environment is monitored using the Prometheus Community Stack.

Monitoring components:

- Prometheus
- Grafana
- Prometheus Operator
- kube-state-metrics
- Node Exporter

Example monitored metrics:

- Pod Health
- CPU Usage
- Memory Usage
- Kubernetes Resource Utilization

---

## High-Level Architecture

```text
                    Developer
                        |
                        v
               GitHub Repository
                        |
                        v
                 Jenkins CI/CD
                        |
        +---------------+---------------+
        |                               |
   Build / Test                   Docker Image
        |                               |
        +---------------+---------------+
                        |
                        v
                      GHCR
                        |
             +----------+----------+
             |                     |
             v                     v
      AWS Deployment      Kubernetes Deployment
             |                     |
         Ansible                Helm
             |                     |
      Docker Compose           Ingress
             |                     |
      TaskFlow + PostgreSQL   TaskFlow + PostgreSQL
                                      |
                                      v
                                 Prometheus
                                      |
                                      v
                                   Grafana
```

---

## Architecture Summary

TaskFlow demonstrates two complete deployment strategies while keeping the application code identical across environments.

The project combines Infrastructure as Code, Configuration Management, CI/CD automation, Kubernetes orchestration and production monitoring into a single end-to-end DevOps platform.
