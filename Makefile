### Kubernetes Command ###
build_subject:
	docker compose -f ./CU-Overflow-Subject-Service/docker-compose.yaml build subject-service

build_filestorage:
	docker compose -f ./SW-Arch-File-Storage-Microservice/docker-compose.prod.yml build app

build_filestorage_migrator:
	docker compose -f ./SW-Arch-File-Storage-Microservice-Migrator/docker-compose.prod.yml build migrator

build_topic:
	docker compose -f ./sw-arch-topic-worker/docker-compose.yml build worker

build_gateway:
	docker compose -f ./API-Gateway-SA/docker-compose.yml build

build_web:
	docker compose -f ./SA-Front-End/docker-compose.yml build

build_images: build_subject build_filestorage build_filestorage_migrator build_topic build_gateway build_web

install_common:
	helm install common ./helm/common

uninstall_common:
	helm uninstall common

install_charts:
	helm install subject-service ./helm/subject-service
	helm install filestorage-service ./helm/file-service
	helm install topic-service ./helm/topic-service
	helm install api-gateway ./helm/api-gateway
	helm install web ./helm/web-service
	helm install ingress ./helm/ingress

uninstall_charts:
	helm uninstall ingress
	helm uninstall web
	helm uninstall api-gateway
	helm uninstall topic-service
	helm uninstall filestorage-service
	helm uninstall subject-service

migrate_db:
	kubectl apply -f ./k8s-file/config-map-secret.yaml
	kubectl apply -f ./k8s-file/db-migrator.yaml

finish_migrate_db:
	kubectl delete -f ./k8s-file/config-map-secret.yaml
	kubectl delete -f ./k8s-file/db-migrator.yaml

init_submodules:
	git submodule update --init --recursive

update_submodules:
	git submodule update --remote --recursive

### DEPRECATED ### 
### Terraform Command ###
create_infras:
	terraform -chdir=./terraform apply -auto-approve

destroy_infras:
	terraform -chdir=./terraform destroy -auto-approve
### END DEPRECATED ###
