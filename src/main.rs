use axum::{Router, routing::get};
use std::net::SocketAddr;
use tokio::net::TcpListener;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let port = 8080;

    // health check
    let app = Router::new().route("/_healthy", get(health_check));

    let addr = SocketAddr::from(([0, 0, 0, 0], port));
    tracing::info!("listening on {}", addr);

    let listener: TcpListener = TcpListener::bind(&addr)
        .await
        .expect("failed to bind address");

    axum::serve(listener, app).await.expect("server error")
}

// Healthy Check Probe
async fn health_check() -> &'static str {
    "OK"
}
