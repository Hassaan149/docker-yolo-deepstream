Here's a clean and professional `README.md` you can use for your public DeepStream + envsubst-based deployment setup. It's designed to be clear for collaborators and open-source users, even if they’re new to the project.

---

# 🎥 DeepStream RTSP App with Dynamic Config (via `envsubst`)

This repository provides a containerized DeepStream application that uses a **template-based configuration system** powered by `envsubst`. This allows environment variables like RTSP stream URIs to be injected at **runtime**.

---

## 🔧 How It Works

1. A **template config file** (`deepstream_app_config_temp.txt`) contains placeholders such as `$SOURCE_URI`.
2. At container startup, a shell script (`start.sh`) uses `envsubst` to:

   * Substitute environment variables into the template
   * Generate a final DeepStream config (`deepstream_app_config.txt`)
3. The `deepstream-app` binary is launched with the generated config.

---

## 📁 File Structure

```bash
.
├── Dockerfile
├── start.sh
├── deepstream_app_config_temp.txt   # Template config with $SOURCE_URI
├── configs/                         # YOLO & analytics config files
├── DeepStream-Yolo/                # DeepStream-Yolo plugin and sources
└── docker-compose.yml
```

---

## ⚙️ Environment Variables

The main required environment variable is:

| Variable     | Description                   |
| ------------ | ----------------------------- |
| `SOURCE_URI` | RTSP input URI for the source |

Set this via `docker-compose.yml` or any container orchestration tool.

---

## 🐳 Docker Compose Usage

### 1. Build and start the service

```bash
docker-compose up --build
```

### 2. Example `docker-compose.yml` (snippet)

```yaml
services:
  deep-stream-service-1:
    build:
      context: ./service
    container_name: deep-stream-service-1
    runtime: nvidia
    environment:
      - SOURCE_URI=rtsp://username:password@camera-ip:554/path
    ports:
      - "5000:5000"
    stdin_open: true
    tty: true
```

---

## 🧠 Why Use a Template?

Hardcoding URIs or secrets into configuration files is insecure and inflexible. Using a templated config file allows:

* Dynamic environment-specific deployments
* Better security via environment variables
* Cleaner version control (no secrets in git)

---

## 🚀 Entry Point: `start.sh`

```sh
#!/bin/sh
envsubst < deepstream_app_config_temp.txt > deepstream_app_config.txt
cat deepstream_app_config.txt
exec deepstream-app -c deepstream_app_config.txt
```

* `envsubst` replaces `$SOURCE_URI` with the actual runtime value
* The final config is printed for verification
* `deepstream-app` runs using the generated config

---

## 🧪 Debugging Tips

* To verify the substitution worked, check the container logs:

  ```bash
  docker logs deep-stream-service-1
  ```
* You should see your full RTSP URI in the printed `deepstream_app_config.txt`.

---

## 📌 Notes

* **Do not include** `deepstream_app_config.txt` in version control — it's generated at runtime.
* Only `deepstream_app_config_temp.txt` (the template) should be tracked.

---

