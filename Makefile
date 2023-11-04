### Kubernetes Command ###
build_subject:
	docker compose -f ./CU-Overflow-Subject-Service/docker-compose.yaml build subject-service

build_gateway:
	docker compose -f ./API-Gateway-SA/docker-compose.yml build

build_web:
	docker compose -f ./SA-Front-End/docker-compose.yml build

build_images: build_subject build_gateway build_web

install_charts:
	helm install subject-service ./helm/subject-service
	helm install api-gateway ./helm/api-gateway
	helm install web ./helm/web-service
	helm install ingress ./helm/ingress

uninstall_charts:
	helm uninstall ingress
	helm uninstall web
	helm uninstall api-gateway
	helm uninstall subject-service

### Terraform Command ###
create_infras:
	terraform -chdir=./terraform apply -auto-approve

destroy_infras:
	terraform -chdir=./terraform destroy -auto-approve
