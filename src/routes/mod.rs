use axum::Router;

pub mod health;

pub fn api_routes() -> Router {
    Router::new().nest("/_healthy", health::routes())
}
