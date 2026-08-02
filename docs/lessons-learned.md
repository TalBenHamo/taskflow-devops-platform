# Lessons Learned

## Docker Images and Containers

A Docker image is a reusable template used to create containers.
Containers are running instances of an image and have their own lifecycle.

---

## Persistent Storage

Application data should not be stored inside containers.

PostgreSQL data is stored in a Docker volume, allowing the database to persist even after containers are recreated.

---

## Service Discovery

Containers should communicate using service names defined in Docker Compose rather than container IP addresses.

For example:

- web
- db

---

## Health Checks

A running container is not always ready to accept connections.

Health checks ensure that dependent services start only after the required service is fully operational.

---

## CI Pipeline Design

A good CI pipeline should be divided into clear stages.

Current TaskFlow pipeline:

1. Checkout
2. Validate
3. Build
4. Test
5. Health Check
6. Tag Image
7. Push Image
8. Cleanup

This makes failures easier to locate and troubleshoot.

---

## Git Workflow

Using feature branches and Pull Requests keeps the main branch stable and makes code reviews easier.

Each completed feature is merged only after successful validation.

---

## Documentation

Documentation should be written continuously throughout the project rather than only before submission.

Keeping documentation updated makes maintenance easier and helps other developers understand the project.
