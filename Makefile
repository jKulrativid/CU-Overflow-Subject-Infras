### Kubernetes Command ###
build_subject:
	docker compose -f ./CU-Overflow-Subject-Service/docker-compose.yaml build subject-service

build_filestorage:
	docker compose -f ./SW-Arch-File-Storage-Microservice/docker-compose.prod.yml build app

build_gateway:
	docker compose -f ./API-Gateway-SA/docker-compose.yml build

build_web:
	docker compose -f ./SA-Front-End/docker-compose.yml build

build_images: build_subject build_filestorage build_gateway build_web

install_pv:
	helm install persistent-volume ./helm/persistent-volumes

uninstall_pv:
	helm uninstall persistent-volume

install_charts:
	helm install subject-service ./helm/subject-service
	helm install filestorage-service ./helm/file-service
	helm install api-gateway ./helm/api-gateway
	helm install web ./helm/web-service
	helm install ingress ./helm/ingress

uninstall_charts:
	helm uninstall ingress
	helm uninstall web
	helm uninstall api-gateway
	helm uninstall filestorage-service
	helm uninstall subject-service

### Terraform Command ###
create_infras:
	terraform -chdir=./terraform apply -auto-approve

destroy_infras:
	terraform -chdir=./terraform destroy -auto-approve
