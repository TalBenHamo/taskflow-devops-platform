# Challenges

Throughout the development of TaskFlow, several technical challenges were encountered. Solving these issues significantly improved the reliability, automation and deployment process of the project.

---

# Docker Container Name Conflict

Docker Compose originally used fixed container names.

When Jenkins created a temporary CI environment, container name collisions caused the pipeline to fail.

## Solution

The fixed `container_name` configuration was removed, allowing Docker Compose to generate unique container names automatically.

---

# Port Conflict

The application uses port **5000**.

Existing local containers occasionally occupied the port, preventing the CI environment from starting.

## Solution

The Jenkins pipeline now creates an isolated Docker Compose project and removes all temporary resources after each build.

---

# PostgreSQL Startup Timing

The Flask application sometimes started before PostgreSQL was ready.

## Solution

A PostgreSQL health check was introduced and the application waits until the database becomes healthy before starting.

---

# Python Import Path

Pytest initially failed because it could not locate the Flask application.

## Solution

The Jenkins pipeline explicitly defines:

```bash
PYTHONPATH=/app
```

before executing the automated tests.

---

# Docker Permissions

The Jenkins service account was unable to execute Docker commands.

## Solution

The Jenkins user was added to the Docker group and the service was restarted.

---

# Jenkins Memory Pressure

One pipeline execution terminated with exit code **137**, indicating insufficient available memory.

## Solution

Unused services, including Minikube, were stopped before running the pipeline, reducing memory consumption.

---

# Kubernetes Image Pull

Minikube was initially unable to pull locally built Docker images.

## Solution

Application images were loaded directly into the Minikube image cache before deployment.

---

# Helm Chart Validation

The Helm chart required multiple validation steps before installation.

## Solution

The deployment process was validated using:

- helm lint
- helm template
- helm install
- helm upgrade
- helm rollback

This ensured that the chart remained reusable and production-ready.

---

# Prometheus Installation

Installing the kube-prometheus-stack required downloading several large container images.

The first deployment took considerably longer than expected.

## Solution

The deployment was monitored until all containers became healthy before validating metrics and Grafana dashboards.

---

# GitHub Webhook

GitHub could not reach the Jenkins server because it was hosted on a private network.

## Solution

SCM Polling was configured in Jenkins, allowing repository changes to automatically trigger the pipeline without exposing Jenkins to the public Internet.

---

# Pull Request Workflow

A Pull Request was initially opened against an incorrect branch.

## Solution

The Pull Request was recreated using the correct target branch, keeping the Git history clean.

---

# Lessons from These Challenges

Every challenge strengthened the overall quality of the project.

The troubleshooting process provided practical experience with:

- Docker
- Jenkins
- Git
- AWS
- Terraform
- Ansible
- Kubernetes
- Helm
- Prometheus
- Grafana

More importantly, these issues demonstrated how real-world DevOps projects require continuous debugging, validation and incremental improvements before reaching a stable production-ready solution.
