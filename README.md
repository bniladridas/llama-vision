# llama/vision

[![GitHub](https://img.shields.io/badge/GitHub-bniladridas%2Fllama--vision-blue)](https://github.com/bniladridas/llama-vision)

A containerized AI vision demo with a FastAPI backend and React frontend for image analysis.

## Features

* FastAPI backend for image analysis
* React frontend with upload interface
* Docker-based deployment
* Unit and E2E testing setup

## Structure

```
llama-vision/
├── backend/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   └── tests/
├── frontend/
│   ├── src/
│   ├── cypress/
│   └── package.json
├── scripts/
├── .github/workflows/
├── docker-compose.yml
└── README.md
```

## Setup

### Prerequisites

* Docker & Docker Compose
* Node.js 18+
* Python 3.9+

### Installation

```bash
git clone https://github.com/bniladridas/llama-vision.git
cd llama-vision
docker compose up --build
```

**Local Development**

```bash
# Backend
cd backend
pip install -r requirements.txt
python -m uvicorn app:app --reload

# Frontend
cd frontend
npm install
npm start
```

**Access**

* Frontend → [http://localhost:3000](http://localhost:3000)
* Backend API → [http://localhost:8001](http://localhost:8001)

## Testing

```bash
# Backend
cd backend && pytest

# Frontend
cd frontend && npm test

# E2E
cd frontend && npm run cypress:open
```

## Contributing

Follow [Conventional Commits](https://www.conventionalcommits.org/).
Example:

```bash
git commit -m "feat: add image analysis dashboard"
```

**Setup**

```bash
cp scripts/commit-msg .git/hooks/commit-msg
```

**Types**
`feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `revert`

## Docker

```bash
docker build -t llama-vision-backend ./backend
docker build -t llama-vision-frontend ./frontend
docker compose up
```