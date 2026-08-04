# Challenges

## Docker Container Name Conflict

Initially, Docker Compose used a fixed container name.

When Jenkins created a separate Docker Compose project for testing, Docker attempted to reuse the same container name, causing the build to fail.

### Solution

The fixed `container_name` configuration was removed, allowing Docker Compose to generate unique container names automatically.

---

## Port 5000 Conflict

During Jenkins pipeline execution, another TaskFlow container was already using port **5000**.

### Solution

The local environment was stopped before running the CI environment, and Jenkins used an isolated Docker Compose project name.

---

## PostgreSQL Startup Timing

The Flask application sometimes started before PostgreSQL was ready, causing connection errors.

### Solution

A PostgreSQL health check was added, and the web service now waits until the database becomes healthy before starting.

---

## Python Import Path

Pytest could not locate the Flask application because the tests and application were stored in different directories.

### Solution

The Jenkins pipeline explicitly defines:

```bash
PYTHONPATH=/app
```

before executing the tests.

---

## Jenkins Memory Issue

One pipeline execution failed with exit code **137**, indicating that the process was terminated due to memory pressure.

### Solution

Unused services such as Minikube were stopped before executing the pipeline, reducing memory usage.

---

## Pull Request Base Branch

A Pull Request was accidentally opened against another feature branch instead of the `main` branch.

### Solution

The mistake was identified, a new Pull Request was created with the correct base branch, and the project history remained clean.

---

## Lessons from These Challenges

Each issue improved the project's reliability and strengthened the CI/CD pipeline. The debugging process also provided practical experience with Docker, Jenkins, Git, and application deployment.
