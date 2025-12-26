
use axum::{Router, routing::get};
use crate::{handlers::health};

pub fn routes() -> Router {
    Router::new()
        .route("/", get(health::health_check))
}
