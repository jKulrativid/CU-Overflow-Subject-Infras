### Kubernetes Command ###
build_subject:
	docker build ./CU-Overflow-Subject-Service/. -t localhost:5000/subject-app
	docker push localhost:5000/subject-app

build_filestorage:
	docker build ./SW-Arch-File-Storage-Microservice/. -t localhost:5000/filestorage-app
	docker push localhost:5000/filestorage-app

build_filestorage_migrator:
	docker build ./SW-Arch-File-Storage-Microservice-Migrator/. -t localhost:5000/filestorage-migrator
	docker push localhost:5000/filestorage-migrator

build_topic:
	docker build ./sw-arch-topic-worker/. -t localhost:5000/topic-worker
	docker push localhost:5000/topic-worker

build_gateway:
	docker build ./API-Gateway-SA/. -t localhost:5000/gateway-app
	docker push localhost:5000/gateway-app

build_web:
	docker build ./SA-Front-End/. -t localhost:5000/web
	docker push localhost:5000/web

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
