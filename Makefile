.PHONY: dev
dev:
	@echo "Starting development server..."
	@poetry run uvicorn starter_python.api:app --reload

.PHONY: build_docker
build_docker:
	@echo "Building docker image..."
	@docker buildx build -t starter-python:latest .

.PHONY: build
build:
	@echo "Building application..."
	@poetry run pyinstaller --clean --onefile --name backend starter_python/main.py