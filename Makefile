run:
	cp .env.example .env
	docker compose build --no-cache
	docker compose up -d

setup-precommit:
	cargo install --locked prek
	brew install pre-commit
	pre-commit install
	pre-commit autoupdate

format:
	cargo fmt
	cargo clippy --fix --allow-dirty

test:
	cargo test -- --nocapture

minikube-apply:
	@if ! minikube status --format="{{.Host}}" | grep -q "Running"; then \
		echo "Starting Minikube..."; \
		minikube start; \
	else \
		echo "Minikube already running"; \
	fi
	docker buildx build --platform linux/amd64 -t stock-rebalancer-app:latest .
	minikube image load stock-rebalancer-app:latest
	kubectl apply -f k8s/deployment.yml
	kubectl apply -f k8s/service.yml
	kubectl apply -f k8s/rebalancing-check-cron.yml
	kubectl rollout status deployment/stock-rebalancer-deployment
	kubectl port-forward service/stock-rebalancer-service 8080:80
