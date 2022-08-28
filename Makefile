init: docker-down docker-pull docker-build docker-up
up: docker-up
down: docker-down

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

show-initial-password:
	docker-compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

mkdir-ssh:
	ssh -p 49224 root@ovz4.j49321827.pqj7n.vps.myjino.ru 'mkdir ~/.ssh/'

copy-ssh-public-key:
	cat ~/.ssh/id_rsa.pub | ssh -p 49224 root@ovz4.j49321827.pqj7n.vps.myjino.ru 'cat >> ~/.ssh/authorized_keys'

deploy:
	ssh deploy@${HOST} -p ${PORT} 'rm -rf jenkins && mkdir jenkins'
	scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:jenkins/docker-compose.yml
	scp -P ${PORT} -r docker deploy@${HOST}:jenkins/docker
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && echo "COMPOSE_PROJECT_NAME=jenkins" >> .env'
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && docker-compose pull'
	ssh deploy@${HOST} -p ${PORT} 'cd jenkins && docker-compose up --build --remove-orphans -d'