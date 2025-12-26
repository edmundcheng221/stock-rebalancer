use crate::handlers::health;
use axum::{Router, routing::get};

pub fn routes() -> Router {
    Router::new().route("/", get(health::health_check))
}
