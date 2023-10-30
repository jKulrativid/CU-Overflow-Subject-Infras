### Kubernetes Command ###
build_subject:
	docker compose -f ./CU-Overflow-Subject-Service/docker-compose.yaml build subject-service

build_gateway:
#	docker compose -f ./API-Gateway-SA/docker-compose.yml build

build_images: build_subject build_gateway

### Terraform Command ###
create_infras:
	terraform -chdir=./terraform apply -auto-approve

destroy_infras:
	terraform -chdir=./terraform destroy -auto-approve
