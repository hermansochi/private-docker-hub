init: docker-down-clear docker-pull docker-build docker-up
up: docker-up
down: docker-down

docker-up:
	docker compose up -d

docker-down:
	docker compose down --remove-orphans

docker-down-clear:
	docker compose down -v --remove-orphans

docker-pull:
	docker compose pull

docker-build:
	docker compose build

show-initial-password:
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && docker compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword'

deploy:
	#ssh deploy@${HOST} -p ${PORT} 'rm -rf registry && mkdir registry'
	#scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:registry/docker-compose.yml
	#scp -P ${PORT} -r docker deploy@${HOST}:registry/docker
	#scp -P ${PORT} provisioning/${HTPASSWD_FILE} deploy@${HOST}:registry/htpasswd
	#ssh deploy@${HOST} -p ${PORT} 'cd registry && echo "COMPOSE_PROJECT_NAME=registry" >> .env'
	#ssh deploy@${HOST} -p ${PORT} 'cd registry && docker-compose down --remove-orphans'
	#ssh deploy@${HOST} -p ${PORT} 'cd registry && docker-compose pull'
	#ssh deploy@${HOST} -p ${PORT} 'cd registry && docker-compose up -d'
	ssh deploy@${HOST} -p ${PORT} 'rm -rf jenkins && mkdir jenkins'
	scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:jenkins/docker-compose.yml
	scp -P ${PORT} -r docker deploy@${HOST}:jenkins/docker
	scp -P ${PORT} provisioning/${HTPASSWD_FILE} deploy@${HOST}:jenkins/htpasswd
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && echo "COMPOSE_PROJECT_NAME=jenkins" >> .env'
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && docker compose down --remove-orphans'
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && docker compose pull'
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && docker compose build --pull'
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && docker compose up -d'
