# Folder Explanation

This document describes the structure of the TaskFlow DevOps Platform repository.

```text
taskflow-devops-platform/
├── app/
├── docs/
├── infra/
├── scripts/
├── tests/
├── Dockerfile
├── compose.yaml
├── Jenkinsfile
└── README.md
```

## app/

Contains the Flask application source code, HTML templates, static files, and Python dependencies.

## docs/

Contains the project documentation, including architecture, deployment explanation, lessons learned, engineering challenges, and future improvements.

## infra/

Contains Infrastructure as Code and configuration management files.

- terraform/
- ansible/ (will be added in the next phase)

## scripts/

Contains Bash automation scripts.

Currently includes:

- TaskFlow Health Check script

## tests/

Contains automated Pytest tests for the application.

## Dockerfile

Defines how the TaskFlow Docker image is built.

## compose.yaml

Defines the local multi-container environment using Docker Compose.

## Jenkinsfile

Defines the Jenkins CI pipeline.

## README.md

Provides the project overview, architecture summary, technology stack, and usage instructions.
