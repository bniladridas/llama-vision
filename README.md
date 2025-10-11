# Llama Vision Project

Multi-platform AI vision system with NVIDIA GPU acceleration (Linux) and Apple Silicon optimization (macOS).

## Platform Support

| Feature              | Linux/NVIDIA                     | macOS                     |
| -------------------- | -------------------------------- | ------------------------- |
| Inference Backend    | CUDA-accelerated (Llama-3.2-90b) | CPU/Metal (Apple Silicon) |
| Docker Support       | GPU via `nvidia-docker2`         | CPU-only                  |
| Latency (P99)        | <500 ms                          | 2–4 s (CPU-dependent)     |
| Quantization Support | Optional                         | Required (4-bit/8-bit)    |

## Key Features

* **Cross-Platform Architecture**

  * NVIDIA NIM integration for Linux
  * Core ML optimization for macOS
* **Enterprise Ready**

  * NVIDIA AI Enterprise validated
  * Signed container images
* **Vision Capabilities**

  * Image reasoning and captioning
  * Visual Q&A with custom prompts

## Technical Specifications

|                     | Linux/NVIDIA                                           | macOS                  |
| ------------------- | ------------------------------------------------------ | ---------------------- |
| **Container Image** | `nvcr.io/nim/meta/llama-3.2-90b-vision-instruct:1.1.1` | Custom CPU/Metal build |
| **Security Scan**   | NSPECT-7EW0-GF3Q                                       | N/A                    |
| **Size**            | 7.66 GB (compressed)                                   | 4.2 GB (quantized)     |
| **Publisher**       | NVIDIA                                                 | Community maintained   |

## Project Structure

```
llama-vision-project/
├── backend/
│   ├── app.py              # Platform-aware inference server
│   ├── Dockerfile          # Conditional build for GPU/CPU
│   ├── requirements.txt    # Python dependencies
│   └── tests/              # Unit tests
├── frontend/               # React visualization dashboard
│   ├── src/
│   ├── cypress/            # E2E tests
│   └── package.json
├── scripts/                # Git hooks and utilities
├── .github/workflows/      # CI/CD workflows
├── docker-compose.yml      # Hybrid deployment config
└── README.md
```

## Setup Guide

### Prerequisites

* **All Platforms**

  * Docker 20.10 + and Docker Compose
  * ≥ 16 GB RAM

* **Linux/NVIDIA**

  ```bash
  nvidia-smi --query-gpu=name --format=csv
  distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
  curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
  curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
  sudo apt-get update && sudo apt-get install -y nvidia-docker2
  ```

* **macOS**

  ```bash
  xcode-select --install
  sysctl -n machdep.cpu.brand_string
  ```

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/bniladridas/llama-vision-project.git
   cd llama-vision-project
   ```

2. **Platform configuration**

   * **Linux/NVIDIA**

     ```yaml
     services:
       llama:
         image: nvcr.io/nim/meta/llama-3.2-90b-vision-instruct:1.1.1
         runtime: nvidia
         environment:
           - NGC_API_KEY=${NGC_API_KEY}
     ```
   * **macOS**

     ```yaml
     services:
       llama:
         image: llama-cpu:latest
         build: 
           context: ./llama-cpu
           dockerfile: Dockerfile.metal
     ```

3. **Start services**

   ```bash
   docker compose up --build
   ```

Access points:

* **Frontend:** [http://localhost:3000](http://localhost:3000)
* **API Docs:** [http://localhost:8001/docs](http://localhost:8001/docs)

## Platform Optimization

### Apple Silicon (Metal)

```python
import torch

def load_model():
    if torch.backends.mps.is_available():
        device = torch.device("mps")
        model = LlamaForVision.from_pretrained(
            "llama-3.2-90b-vision",
            device_map=device,
            load_in_4bit=True
        )
    else:
        model = load_cpu_quantized_model()
    return model
```

### NVIDIA GPU Acceleration

```yaml
services:
  llama:
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu, utility]
```

## Troubleshooting

**macOS GPU Errors**

```bash
ERROR: Could not select device driver with capabilities: [[gpu]]
```

Use the CPU/Metal configuration:

```bash
docker compose -f docker-compose.yml -f docker-compose.metal.yml up
```

**Linux CUDA Errors**

```bash
CUDA error: no kernel image is available for execution
```

Update NVIDIA drivers to ≥ 535.86.05:

```bash
sudo apt-get install nvidia-driver-535
```

## Compliance & Security

* NVIDIA AI Enterprise validated (Linux)
* **Security Scan (Linux)**

  * CVEs: 0 critical
  * SBOM available via NGC portal
* **macOS Build**

  * Signed with Apple Developer ID
  * Homebrew-compatible installation

## Contributing

```bash
# For NVIDIA features
git checkout -b feature/nvidia-optimization

# For Apple Silicon features
git checkout -b feature/metal-enhancement
```

**Test Matrix**

```markdown
- [ ] Linux: pytest --platform=nvidia
- [ ] macOS: pytest --platform=metal
- [ ] CPU: pytest --platform=cpu
```

## Conventional Commits

Follow **Conventional Commits** for all contributions.

**Setup**

```bash
cp scripts/commit-msg .git/hooks/commit-msg
chmod +x .git/hooks/commit-msg
```

**Usage**

* Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `revert`
* Lowercase, ≤ 60 chars summary

Example:

```bash
git commit -m "feat: add image analysis dashboard"
```

**Rewrite existing commits**

```bash
./scripts/rewrite_msg.sh
```

## Testing

**Backend**

```bash
pip install -r backend/requirements.txt
pytest backend/tests/
```

**Frontend**

```bash
cd frontend && npm install
npm test
```

**E2E Tests**

```bash
docker compose up
cd frontend && npm run cypress:open
```

## Docker Hub Instructions

**Build Images**

```bash
docker build -t <username>/backend:latest ./backend
docker build -t <username>/frontend:latest ./frontend
```

**Tag Images**

```bash
docker tag <username>/backend:latest <username>/backend:latest
docker tag <username>/frontend:latest <username>/frontend:latest
```

**Push to Docker Hub**

```bash
docker push <username>/backend:latest
docker push <username>/frontend:latest
```