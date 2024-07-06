import os
import reflex as rx

config = rx.Config(
    app_name="reflex_on_fly_deployment",
    api_url=os.environ.get("API_URL", "http://localhost:8000"),
    db_url=os.environ.get("DATABASE_URL", "postgresql://reflex:reflex@0.0.0.0:5432/reflex"),
)
