mod handlers;
mod routes;

use axum::Router;
use dotenvy::dotenv;
use std::{env, net::SocketAddr};
use tokio::net::TcpListener;

#[tokio::main]
async fn main() {
    let run_mode = env::var("RUN_MODE").ok().unwrap_or_default();

    if run_mode == "job" {
        println!("Running JOB handler...");
        tokio::time::sleep(tokio::time::Duration::from_secs(2)).await;
        return; // simply exit for now
    }

    // load stuff from local .env file
    dotenv().ok();

    tracing_subscriber::fmt::init();

    let port = 8080;

    let app = Router::new().merge(routes::api_routes());

    let addr = SocketAddr::from(([0, 0, 0, 0], port));
    tracing::info!("listening on {}", addr);

    let listener: TcpListener = TcpListener::bind(&addr)
        .await
        .expect("failed to bind address");

    axum::serve(listener, app).await.expect("server error")
}
