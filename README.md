## About

Tax loss harvesting is a strategy that involves selling investments at a loss to offset capital gains. 

For example, if you realised \$10.000 in gains, you can sell underperforming assets at a loss so that you don't have to pay capital gains
tax on the entire \$10.000 of gains. If you realise more than \$10.000 in losses, you can even offset up to $3.000 in ordinary income per year.

Direct indexing takes this a step further. If you buy the underlying assets within an ETF, you can tax loss harvest by selling
individual assets that that ETF holds. This is very favourable for multiple reasons.

1. You can get the gains from the overall market by tracking the holdings of ETFs such as the S&P500.
2. You can tax loss harvest the losers thus reducing your tax burden.
3. You don't have to pay the expense ratio of the fund because you own all the shares (at the right percent allocation).

## Motivation

Direct indexing + tax loss harvesting strategies often times require a high net worth asset manager to handle this for you. This asset manager will
likely charge a fee in addition to the expense ratio of the fund.

1. I don't want to pay an advisor.
2. I don't want to pay expense ratios.
3. I want to reduce my tax burden.

## Design Considerations

* Extensibility
  * Build connectors so this works with any brokerage
  * Build so that I can apply direct indexing across any ETF

## Todo

- Everything lol
- Add connector to Schwab
  - Get investments
  - Get lots
  - etc.
- Add notification service
- Direct indexing

## Local Development

First, fill out .env.example with your secrets.

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

Apply Cron

```bash
kubectl apply -f k8s/rebalancing-check-cron.yml
```

Load image

```bash
minikube image load stock-rebalancer-app:latest
```

Port Forward

```bash
kubectl port-forward service/stock-rebalancer-service 8080:80
```

Verify pods/cron/jobs are running

```bash
kubectl -n default get pods
kubectl -n default get cronjob
kubectl -n default get jobs --watch
```

OR simply

```bash
make minikube-apply
```




Verify app can be accessible at `http://localhost:8080/_healthy`
