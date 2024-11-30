# INTRODUCTION TO DOCKER
A **Dockerfile** is a text file that contains a set of instructions used to automate the creation of a Docker image. It defines the environment, software dependencies, configurations, and commands that will be executed inside a container when it is built and run. Dockerfiles are used by Docker to build images, which can then be used to create containers.

Here's a breakdown of common Dockerfile instructions:

1. **FROM**: Specifies the base image to use (e.g., `FROM ubuntu:20.04`).
2. **RUN**: Executes commands inside the image, such as installing software packages (e.g., `RUN apt-get update`).
3. **COPY**: Copies files or directories from your local filesystem to the image (e.g., `COPY . /app`).
4. **ADD**: Similar to `COPY`, but can also handle URLs and unpack compressed files.
5. **WORKDIR**: Sets the working directory for subsequent instructions (e.g., `WORKDIR /app`).
6. **CMD**: Specifies the default command to run when a container is started (e.g., `CMD ["python", "app.py"]`).
7. **EXPOSE**: Informs Docker that the container will listen on specific ports (e.g., `EXPOSE 80`).
8. **ENV**: Sets environment variables in the container (e.g., `ENV APP_ENV=production`).
9. **ENTRYPOINT**: Defines the command that will always run when the container starts, even if a different command is provided at runtime.
10. **VOLUME**: Creates a mount point for volumes, allowing data persistence (e.g., `VOLUME /data`).

### Example Dockerfile:
```dockerfile
# Use the official Python image as the base image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install any necessary dependencies
RUN pip install -r requirements.txt

# Expose port 5000
EXPOSE 5000

# Define the default command to run the app
CMD ["python", "app.py"]
```

### Key Uses of a Dockerfile:
- **Reproducibility**: The same Dockerfile can be used to build the same environment across different systems, ensuring consistency.
- **Automation**: A Dockerfile allows you to automate the process of building an image with specific configurations and software.
- **Portability**: Once built, Docker images can be shared and run on any platform that supports Docker.

In essence, a Dockerfile is a blueprint for creating Docker images, ensuring the environment is consistent and reproducible.