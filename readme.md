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

# Snigdha OS Docker 🚀

[Snigdha OS](https://github.com/Snigdha-OS/snigdhaos-docker) is a minimal operating system designed to run in Docker containers. It is a lightweight, open-source solution for users looking to leverage SnigdhaOS within Docker environments. This repository provides the necessary files to build and run SnigdhaOS containers.

### 🛠️ Features

- **Lightweight and minimal**: Optimized for Docker environments with minimal resource usage.
- **Customizable**: Tailor the OS to your needs by modifying configurations and adding your own tools.
- **Docker-ready**: Pre-configured Dockerfile for easy deployment in containerized environments.

### 📋 Prerequisites

Before you start, make sure you have the following installed on your local machine:

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Git**: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### 🚀 Getting Started

#### 1. Clone the repository

To get started with SnigdhaOS Docker, first, clone this repository to your local machine:

```bash
git clone https://github.com/Snigdha-OS/snigdhaos-docker.git
cd snigdhaos-docker
```

#### 2. Build the Docker image

Once you have cloned the repository, you can build the Docker image using the Dockerfile provided:

```bash
docker build -t snigdhaos:latest .
```

This command will create a Docker image named `snigdhaos` tagged with `latest`.

#### 3. Run the Docker container

After building the Docker image, you can run SnigdhaOS in a container:

```bash
docker run -it snigdhaos:latest
```

This will start a new Docker container and open an interactive terminal session with SnigdhaOS running inside it.

#### 4. Docker Compose (Optional)

If you'd like to run SnigdhaOS with Docker Compose for easier management, you can use the provided `docker-compose.yml` file. To start the container with Docker Compose, run:

```bash
docker-compose up -d
```

This will launch the container in the background. To stop the container, run:

```bash
docker-compose down
```

### 🔧 Customization

You can customize SnigdhaOS for your use case by modifying the Dockerfile or by extending it with additional tools and libraries. After making changes, rebuild the image using the command:

```bash
docker build -t snigdhaos:latest .
```

### 🤝 Contributing

Contributions are welcome! If you'd like to improve SnigdhaOS Docker, feel free to fork the repository and submit a pull request with your changes.

### Steps to contribute:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them.
4. Push your changes and create a pull request.

### 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### 🙏 Acknowledgements

- **Docker**: For providing an easy-to-use containerization platform.
- **SnigdhaOS**: For the core OS functionalities that can be containerized.

### 👨‍💻 Developer

This project is maintained by **Eshan Roy | eshanized**.
