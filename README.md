# Rails Ruby Microservice

A production-friendly Rails API-only microservice starter with versioned REST endpoints, consistent JSON responses, request ID propagation, centralized error handling, tests, Docker, and CI.

## Stack

- Ruby 3.3+
- Rails 8.1 API-only mode
- SQLite for local development and tests
- Puma web server
- Minitest integration tests
- Docker and Docker Compose

## Included Features

- API-only Rails application
- Versioned API under `/api/v1`
- Root service metadata endpoint
- Health and readiness endpoints
- Example `items` module
- Controller → service → repository structure
- Active Record model and migration
- Consistent JSON success/error responses
- Centralized exception handling
- Request ID response header with `X-Request-Id`
- Invalid JSON handling
- Unknown route handling
- Unsupported method handling
- Outbound HTTP client placeholder
- Event publisher placeholder
- Active Job worker placeholder
- Dockerfile
- Docker Compose
- GitHub Actions CI
- Brakeman and RuboCop Rails dev tooling

## Project Structure

```txt
rails-ruby-microservice/
├─ app/
│  ├─ clients/
│  ├─ controllers/
│  │  ├─ api/v1/
│  │  └─ concerns/
│  ├─ errors/
│  ├─ events/
│  ├─ jobs/
│  ├─ models/
│  ├─ repositories/
│  ├─ serializers/
│  └─ services/
├─ bin/
├─ config/
├─ db/
├─ test/
├─ Dockerfile
├─ docker-compose.yml
├─ Gemfile
└─ README.md
```

## Quick Start

```bash
bundle install
cp .env.example .env
bin/rails db:prepare
bin/rails server -b 0.0.0.0 -p 3000
```

Open:

```txt
http://localhost:3000
http://localhost:3000/api/v1/health
http://localhost:3000/api/v1/ready
```

## Endpoints

```txt
GET  /                     Service metadata
GET  /api/v1/health        Health check
GET  /api/v1/ready         Readiness check
GET  /api/v1/items         List items
POST /api/v1/items         Create item
GET  /api/v1/items/:id     Get item by ID
```

## Example Request

```bash
curl -X POST http://localhost:3000/api/v1/items \
  -H "Content-Type: application/json" \
  -H "X-Request-Id: demo-request-1" \
  -d '{"name":"Keyboard","description":"Mechanical keyboard","price":99.99}'
```

Expected response:

```json
{
  "ok": true,
  "data": {
    "id": "...",
    "name": "Keyboard",
    "description": "Mechanical keyboard",
    "price": "99.99",
    "created_at": "...",
    "updated_at": "..."
  }
}
```

## Test

```bash
bin/rails test
```

Full local check:

```bash
bundle exec rubocop
bundle exec brakeman -q
bin/rails test
```

Or:

```bash
make check
```

## Docker

```bash
cp .env.example .env
docker compose up --build
```

Then open:

```txt
http://localhost:3000
```

## Environment Variables

Copy `.env.example` to `.env` for local development.

```txt
SERVICE_NAME=rails-microservice
APP_VERSION=0.1.0
PORT=3000
RAILS_ENV=development
RAILS_LOG_LEVEL=info
RAILS_MAX_THREADS=5
CORS_ORIGINS=*
```

Do not commit real secrets. Keep credentials, API keys, database passwords, and tokens out of Git.

## Production Notes

Before using this in production:

1. Replace SQLite with PostgreSQL or your managed database if persistence matters.
2. Set `SECRET_KEY_BASE` securely.
3. Restrict `CORS_ORIGINS`.
4. Configure structured log collection.
5. Add authentication/authorization for private endpoints.
6. Add rate limiting at your gateway, load balancer, or Rack middleware.
7. Add external monitoring and tracing.
