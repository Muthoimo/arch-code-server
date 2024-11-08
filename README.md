
---

# Arch Coder: Arch Linux with VS Code in the Browser

`arch-code-server` is a Docker-based project that sets up an Arch Linux container with the following features:

- **VS Code (code-server)** running in the browser.
- **Go** installed.
- **Zsh** as the default shell in VS Code.
- **Sudo** configured to allow the `coder` user to run commands without a password prompt.
- Persistent workspace directory mounted from the host machine at `~/.docs/coder`.
- **Hostname** set to `arch`.

## Repository

This project can be found on GitHub at:

[https://github.com/Muthoimo/arch-code-server](https://github.com/Muthoimo/arch-code-server)

## Prerequisites

Before you begin, make sure you have the following installed on your machine:

- **Docker**: For building and running containers.
- **Docker Compose**: For managing multi-container applications with a simple configuration file.

## Project Structure

After cloning the repository, the project directory will look like this:

```
/arch-code-server
    ├── docker-compose.yml
    ├── Dockerfile
    ├── entrypoint.sh
    └── README.md
```

## How to Get Started

### 1. Clone the Repository

First, clone the repository from GitHub to your local machine:

```bash
git clone https://github.com/Muthoimo/arch-code-server.git
cd arch-code-server
```

### 2. Build the Docker Image

Once you have the repository, build the Docker image using Docker Compose. In the terminal, run:

```bash
docker-compose build
```

This command will pull the required base images and install the necessary dependencies defined in the `Dockerfile`.

### 3. Start the Container

After building the Docker image, you can start the container in detached mode by running:

```bash
docker-compose up -d
```

This will start the container in the background, running the VS Code server and all required services.

### 4. Access VS Code in the Browser

Once the container is running, open your browser and go to:

[http://localhost:8080](http://localhost:8080)

You will see VS Code running in the browser, and the `coder` user will have **sudo** privileges without a password prompt. Zsh is set as the default shell in VS Code.

### 5. Configuration and Persistent Storage

- The container mounts the host machine's `~/.docs/coder` directory into the container at `/home/coder/.docs/coder`, so any configuration files or workspace data will persist even if the container is stopped or removed.
- The default workspace is set to `/home/coder`.

### 6. Stop the Container

To stop and remove the container, simply run:

```bash
docker-compose down
```

This will stop the container and remove it. However, all your files in `~/.docs/coder` on your host machine will remain intact.

## Notes

- **VS Code** runs on port `8080`, so make sure that port is open in your firewall if you're accessing it from a remote machine.
- The **`coder`** user has **sudo** capabilities without requiring a password, which can be helpful for development and testing environments.
- The container uses `fixuid` to ensure that user permissions are correctly managed when using mounted volumes.
- **Zsh** is the default shell in VS Code for a more pleasant shell experience.
- You can find your configuration files in the `~/.docs/coder` directory on the host machine, and they will be mounted into the container.

## Customization

- You can change the default user (`coder`) or the workspace location by modifying the `Dockerfile` and `entrypoint.sh`.
- If you want to expose additional ports for other services, you can modify the `docker-compose.yml` file.

---

