# TaskFlow Architecture

## Current Architecture

TaskFlow currently uses a containerized multi-service architecture managed by Docker Compose.

```text
Developer
    |
    v
GitHub Repository
    |
    v
Jenkins CI Pipeline
    |
    +--> Validate Python syntax
    +--> Build Docker image
    +--> Start Docker Compose
    +--> Run automated tests
    +--> Health Check
    +--> Tag Docker image
    +--> Push image to GHCR
    |
    v
GitHub Container Registry

Local Environment
    |
    +--> Flask Container
    |
    +--> PostgreSQL Container
    |
    +--> Docker Volume
```

## Components

### Flask

Provides the TaskFlow web application and health endpoint.

### PostgreSQL

Stores the application data.

### Docker Compose

Runs the application and database together.

### Jenkins

Runs the CI pipeline automatically.

### GitHub Container Registry

Stores the Docker images produced by Jenkins.


---

# Operating System Decision

The project uses **Ubuntu 22.04 LTS** as the primary Linux operating system.

Ubuntu was selected because it provides:

- Long-Term Support (LTS)
- Excellent compatibility with Docker, Jenkins, Terraform, Ansible, and Kubernetes
- Stable package management
- Large community support

Administrative tasks are performed using **sudo**, while day-to-day work is executed using a regular user account.







## Future Architecture

The next project phases will add:

- AWS Infrastructure
- Terraform
- Ansible
- Kubernetes
- Helm
- Prometheus
- Grafana
