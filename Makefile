run:
	cp .env.example .env
	docker compose build --no-cache
	docker compose up

format:
	cargo fmt
	cargo clippy --fix --allow-dirty

test:
	cargo test -- --nocapture

minikube-apply:
	minikube start
	# Force the build to linux/amd64 for Minikube compatibility
	docker build --platform linux/amd64 -t stock-rebalancer-app:latest .
	minikube image load stock-rebalancer-app:latest
	kubectl apply -f k8s/deployment.yml
	kubectl apply -f k8s/service.yml
	kubectl apply -f k8s/rebalancing-check-cron.yml
	@echo "Waiting for deployment..."
	kubectl rollout status deployment/stock-rebalancer-deployment
	kubectl port-forward service/stock-rebalancer-service 8080:80
