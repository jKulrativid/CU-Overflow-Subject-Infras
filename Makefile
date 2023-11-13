### Kubernetes Command ###
build_subject:
	docker build ./CU-Overflow-Subject-Service/. -t jkulrativ/subject-app
	docker push jkulrativ/subject-app:latest

build_filestorage:
	docker build ./SW-Arch-File-Storage-Microservice/. -t jkulrativ/filestorage-app
	docker push jkulrativ/filestorage-app:latest

build_filestorage_migrator:
	docker build ./SW-Arch-File-Storage-Microservice-Migrator/. -t jkulrativ/filestorage-migrator
	docker push jkulrativ/filestorage-migrator:latest

build_topic:
	docker build ./sw-arch-topic-worker/. -t jkulrativ/topic-worker
	docker push jkulrativ/topic-worker:latest

build_gateway:
	docker build ./API-Gateway-SA/. -t jkulrativ/gateway-app
	docker push jkulrativ/gateway-app:latest

build_web:
	docker build ./SA-Front-End/. --build-arg="VITE_GATEWAY_URL=http://${PUBLIC_IP}:8000" --build-arg="VITE_DOMAIN=${PUBLIC_IP}" -t jkulrativ/web
	docker push jkulrativ/web:latest

build_images: build_subject build_filestorage build_filestorage_migrator build_topic build_gateway build_web

install_common:
	helm install common ./helm/common

upgrade_common:
	helm upgrade common ./helm/common --reset-values

uninstall_common:
	helm uninstall common

install_charts:
	helm install subject-service ./helm/subject-service
	helm install filestorage-service ./helm/file-service
	helm install topic-service ./helm/topic-service
	helm install api-gateway ./helm/api-gateway
	helm install web ./helm/web-service
	helm install ingress ./helm/ingress

upgrade_charts:
	helm upgrade subject-service ./helm/subject-service --reset-values
	helm upgrade filestorage-service ./helm/file-service --reset-values
	helm upgrade topic-service ./helm/topic-service --reset-values
	helm upgrade api-gateway ./helm/api-gateway --reset-values
	helm upgrade web ./helm/web-service --reset-values
	helm upgrade ingress ./helm/ingress --reset-values

uninstall_charts:
	helm uninstall ingress
	helm uninstall web
	helm uninstall api-gateway
	helm uninstall topic-service
	helm uninstall filestorage-service
	helm uninstall subject-service

migrate_db:
	kubectl apply -f ./k8s-file/db-migrator.yaml

finish_migrate_db:
	kubectl delete -f ./k8s-file/db-migrator.yaml

init_submodules:
	git submodule update --init --recursive

update_submodules:
	git submodule update --remote --recursive

gen_cert:
	mkdir -p certs
	openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes -subj "/C=TH/ST=BangkokMetropolitan/L=Bangkok/O=CU-Overflow/OU=SiteReliability/CN=Release-1.0"

read_cert:
	kubectl create secret tls ingress-cert --key=certs/ingress-tls.key --cert=certs/ingress-tls.crt -o yaml

### DEPRECATED ### 
### Terraform Command ###
create_infras:
	terraform -chdir=./terraform apply -auto-approve

destroy_infras:
	terraform -chdir=./terraform destroy -auto-approve
### END DEPRECATED ###
