### Kubernetes Command ###
build_subject:
	docker compose -f ./CU-Overflow-Subject-Service/docker-compose.yaml build subject-service

build_gateway:
#	docker compose -f ./API-Gateway-SA/docker-compose.yml build

build_images: build_subject build_gateway

install_services:
	helm install subject-service ./helm/subject-service
	helm install ingress ./helm/ingress

uninstall_services:
	helm uninstall subject-service subject-service
	helm uninstall ingress ingress

### Terraform Command ###
create_infras:
	terraform -chdir=./terraform apply -auto-approve

destroy_infras:
	terraform -chdir=./terraform destroy -auto-approve
