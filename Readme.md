# Dockerize an SSH service

Docker image to create a container exposing a ssh service based on [this official example](https://docs.docker.com/engine/examples/running_ssh_service/).

## Install

```
git clone https://github.com/shyd/docker-sshd.git
docker build -t shyd/sshd ./docker-sshd
```

## Run

```
docker run -d -p 2222:22 -v ssh-root:/root -v etc-ssh:/etc/ssh --name sshd shyd/sshd
```

Make sure to use named volumes in order to allow default content to be placed inside on first run.

## Connect

```
ssh -p 2222 root@localhost
```
