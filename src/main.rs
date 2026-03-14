mod handlers;
mod routes;

use axum::Router;
use dotenvy::dotenv;
use std::net::SocketAddr;
use tokio::net::TcpListener;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    // load env
    dotenv().ok();

    let port = 8080;

    let app = Router::new().merge(routes::api_routes());

    let addr = SocketAddr::from(([0, 0, 0, 0], port));
    tracing::info!("listening on {}", addr);

    let listener: TcpListener = TcpListener::bind(&addr)
        .await
        .expect("failed to bind address");

    axum::serve(listener, app).await.expect("server error")
}
