# Llama Vision Project

A demo AI vision application with backend API and React frontend for image analysis.

## Features
- Backend API for image analysis (placeholder)
- React frontend with upload interface
- Docker containerization
- Unit and E2E testing setup

## Project Structure
```
llama-vision-project/
├── backend/
│   ├── app.py              # FastAPI server
│   ├── Dockerfile          # Container build
│   ├── requirements.txt    # Python dependencies
│   └── tests/              # Unit tests
├── frontend/               # React app
│   ├── src/
│   ├── cypress/            # E2E tests
│   └── package.json
├── scripts/                # Git hooks and utilities
├── .github/workflows/      # CI/CD workflows
├── docker-compose.yml      # Deployment config
└── README.md
```

## Setup

### Prerequisites
- Docker & Docker Compose
- Node.js 18+ (for frontend development)
- Python 3.9+ (for backend development)

### Installation
1. Clone repository:
   ```bash
   git clone https://github.com/bniladridas/llama-vision-project.git
   cd llama-vision-project
   ```

2. Start with Docker Compose:
   ```bash
   docker compose up --build
   ```

3. Or run locally:
   - Backend: `cd backend && pip install -r requirements.txt && python -m uvicorn app:app --reload`
   - Frontend: `cd frontend && npm install && npm start`

Access:
- Frontend: `http://localhost:3000`
- Backend API: `http://localhost:8001`

## Development
- Backend: FastAPI with placeholder image analysis endpoints
- Frontend: React app with file upload and display
- Testing: Pytest for backend, Jest for frontend, Cypress for E2E

## Testing
- Backend: `cd backend && pytest`
- Frontend: `cd frontend && npm test`
- E2E: `cd frontend && npm run cypress:open`

## Contributing
Use conventional commits: `type: description` (e.g., `feat: add new feature`).

## Conventional Commits
Follow conventional commits for all contributions.

**Setup**
```bash
cp scripts/commit-msg .git/hooks/commit-msg
```

**Usage**
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `revert`
- Lowercase, ≤60 chars summary

Example:
```bash
git commit -m "feat: add image analysis dashboard"
```

**Rewrite existing commits**
```bash
./scripts/rewrite_msg.sh
```

## Docker
Build images:
```bash
docker build -t backend ./backend
docker build -t frontend ./frontend
```

Run with compose: `docker compose up`