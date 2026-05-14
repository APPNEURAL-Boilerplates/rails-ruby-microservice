.PHONY: setup dev test lint security check docker-up docker-down

setup:
	bundle install
	cp -n .env.example .env || true
	bin/rails db:prepare

dev:
	bin/rails server -b 0.0.0.0 -p $${PORT:-3000}

test:
	bin/rails test

lint:
	bundle exec rubocop

security:
	bundle exec brakeman -q

check: lint security test

docker-up:
	docker compose up --build

docker-down:
	docker compose down
