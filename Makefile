init: docker-down-clear docker-build docker-up
down: docker-down
restart: docker-up
down-clear: docker-down-clear
docker-up:
	docker-compose up -d
docker-down:
	docker-compose down --remove-orphans
docker-down-clear:
	docker-compose down -v --remove-orphans
docker-build:
	docker-compose build --pull
build: build-gateway build-frontend build-api
build-gateway:
	docker --log-level=debug build --pull --file=gateway/docker/production/nginx/Dockerfile --tag=${REGISTRY}/auction-gateway:${IMAGE_TAG} gateway/docker/production/nginx
build-frontend:
	docker --log-level=debug build --pull --file=frontend/docker/production/nginx/Dockerfile --tag=${REGISTRY}/auction-frontend:${IMAGE_TAG} frontend
build-api:
	docker --log-level=debug build --pull --file=api/docker/production/php-fpm/Dockerfile --tag=${REGISTRY}/auction-api:${IMAGE_TAG} api
	docker --log-level=debug build --pull --file=api/docker/production/nginx/Dockerfile --tag=${REGISTRY}/auction-api:${IMAGE_TAG} api
try-build:
	REGISTRY=localhost IMAGE_TAG=0 make build
push: push-gateway push-frontend push-api
push-gateway:
	docker-push ${REGISTRY}/auction-gateway:${IMAGE_TAG}
push-frontend:
	docker-push ${REGISTRY}/auction-frontend:${IMAGE_TAG}
push-api:
	docker-push ${REGISTRY}/auction-api:${IMAGE_TAG}
	docker-push ${REGISTRY}/auction-api-php-fpm:${IMAGE_TAG}
