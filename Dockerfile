# This Dockerfile is used to deploy a simple single-container Reflex app instance.
FROM python:3.11

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app
COPY . .

RUN pip install -U pip && pip install poetry
RUN poetry install --no-root --no-dev

# Deploy templates and prepare app
RUN poetry run reflex init

# Needed until Reflex properly passes SIGTERM on backend.
STOPSIGNAL SIGKILL

# Always apply migrations before starting the backend.
CMD poetry run reflex db migrate && poetry run reflex run --env prod --backend-only
