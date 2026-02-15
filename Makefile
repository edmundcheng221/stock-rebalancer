run:
	docker compose build --no-cache
	docker compose up

format:
	cargo fmt
	cargo clippy --fix --allow-dirty

test:
	cargo test -- --nocapture
