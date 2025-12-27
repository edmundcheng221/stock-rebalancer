## About

Tax Loss Harvesting Checker.

## Local Development

```bash
make run
```

Verify that server is running:

> http://localhost:8080/_healthy

## Fix Formatting/Linting

Formatting:

```bash
cargo fmt
```

Linting:

```bash
cargo clippy --fix
```

Apply both:

```bash
make format
```

## Local Minikube Deployment

Build image

```bash
docker compose build --no-cache
```

Apply deployment

```bash
kubectl apply -f k8s/deployment.yml
```

Apply Service

```bash
kubectl apply -f k8s/service.yml
```

Load image

```bash
minikube image load stock-rebalancer-app:latest
```

Port Forward

```bash
kubectl port-forward service/stock-rebalancer-service 8080:80
```

Verify pods are running

```bash
kubectl -n default get pods
```

Verify app can be accessible at `http://localhost:8080/_healthy`
