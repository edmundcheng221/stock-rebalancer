use axum::Router;

pub mod health;
pub mod ready;

pub fn api_routes() -> Router {
    Router::new()
        .nest("/_healthy", health::routes())
        .nest("/_ready", ready::routes())
}
