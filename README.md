## About

Tax Loss Harvesting Checker.

## Local Development

```bash
docker compose build --no-cache
docker compose up
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
