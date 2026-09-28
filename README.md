# docker-flask

[![Docker Pulls](https://img.shields.io/docker/pulls/techblog/flask)](https://hub.docker.com/r/techblog/flask)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue)](License)

A base Docker image for [Flask](https://flask.palletsprojects.com/) applications. It comes with Python 3, Flask, Flask-RESTful and a few commonly used libraries already installed, so your own image only needs to add your code and any extra dependencies.

## Image versions

| Tag | Base | Status |
|-----|------|--------|
| `techblog/flask:latest`, `techblog/flask:3.0.0` | `ubuntu:18.04` (end of life) | Published on Docker Hub (December 2023) for `linux/amd64` and `linux/arm64`. |
| `4.1.0` (current source) | `ubuntu:24.10` (end of life) | Not published, and a fresh build fails (see [Building the image](#building-the-image)). |

Older tags (`1.0.0`, `1.1.0`, `1.2.0`, `2.0.0`, `dev`, `1.2.0-dev`) are also on Docker Hub; they were built for `linux/amd64`, `linux/arm64` and `linux/arm/v7`.

## What's included

### Published image (`latest` / `3.0.0`)

Ubuntu 18.04 with Python 3.6.9 and pip 21.3.1, plus Flask 2.0.3, Flask-RESTful 0.3.10, loguru 0.7.2, requests 2.27.1, cryptography 2.6.1, urllib3 1.26.18 and Werkzeug 2.0.3.

### Current source (`4.1.0`, not published)

System packages: `python3-pip`, `libffi-dev`, `libssl-dev` and `fping`.

Python packages from [`requirements.txt`](requirements.txt):

| Package | Version |
|---------|---------|
| [Flask](https://flask.palletsprojects.com/) | latest at build time |
| [Flask-RESTful](https://flask-restful.readthedocs.io/) | latest at build time |
| [loguru](https://loguru.readthedocs.io/) | latest at build time |
| [requests](https://requests.readthedocs.io/) | latest at build time |
| [cryptography](https://cryptography.io/) | 46.0.5 |
| urllib3 | ≥ 2.2.2 |
| Werkzeug | ≥ 3.1.5 |

The image sets `PYTHONIOENCODING=utf-8` and `LANG=C.UTF-8`. It sets no `WORKDIR`, `EXPOSE` or `CMD` of its own (the base image's default applies); your own Dockerfile sets those.

## Usage

Use the image as the base for your application's Dockerfile:

```dockerfile
FROM techblog/flask:latest

WORKDIR /opt/app

# Extra dependencies, if any
COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["python3", "app.py"]
```

Here `app.py` starts Flask itself, for example with `app.run(host="0.0.0.0", port=8080)`.

## Building the image

```bash
git clone https://github.com/t0mer/docker-flask.git
cd docker-flask
docker build -t flask-base:local .
```

> **Known issue:** the current Dockerfile uses `ubuntu:24.10`, which reached end of life in July 2025. Its packages have moved to `old-releases.ubuntu.com`, so the `apt update` step fails (404 from `archive.ubuntu.com`) until the base image is changed.

## CI

| Workflow | Trigger | Publishes |
|----------|---------|-----------|
| [`main.yml`](.github/workflows/main.yml) | GitHub release published | Docker Hub `techblog/flask:latest` and `:<VERSION>`, for amd64, arm64 and arm/v7 |
| [`docker-image.yml`](.github/workflows/docker-image.yml) | Manual | Docker Hub `techblog/flask:latest` and `:<VERSION>`, for amd64 and arm64 |
| [`publish-ghcr.yml`](.github/workflows/publish-ghcr.yml) | Manual | `ghcr.io/t0mer/flask:latest` and `:<tag input>`, for amd64, arm64 and arm/v7 (no public image yet) |
| [`docker-jcr.yml`](.github/workflows/docker-jcr.yml) | Manual | A private JFrog registry |

The Docker Hub and JFrog workflows read the version tag from the [`VERSION`](VERSION) file; the GHCR workflow uses the tag you enter when starting it (default `latest`).

## License

[Apache License 2.0](License)
