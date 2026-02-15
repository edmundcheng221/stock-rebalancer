use crate::handlers::ready;
use axum::{Router, routing::get};

pub fn routes() -> Router {
    Router::new().route("/", get(ready::ready_check))
}
