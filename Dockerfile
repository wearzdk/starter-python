FROM acidrain/python-poetry:3.11-alpine as build-stage
RUN apk add binutils
WORKDIR /app
COPY ./pyproject.toml ./poetry.lock /app/
RUN --mount=type=cache,id=poetry-cache,target=/root/.cache/pypoetry/cache \
  --mount=type=cache,id=poetry-artifacts,target=/root/.cache/pypoetry/artifacts \
  poetry install --no-interaction --no-ansi

COPY . /app/
RUN poetry run pyinstaller --clean --onefile --name backend starter_python/main.py

FROM alpine:latest
ENV FASTAPI_ENV=production
WORKDIR /app
COPY --from=build-stage /app/dist/backend /app/backend

EXPOSE 8000
CMD ["./backend"]