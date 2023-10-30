install:
	kubectl apply -f config-map-secret.yaml
	kubectl apply -f persistent-volume-claim.yaml
	kubectl apply -f pod.yaml
	kubectl apply -f service.yaml

uninstall:
	kubectl delete -f service.yaml
	kubectl delete -f pod.yaml
	kubectl delete -f persistent-volume-claim.yaml
	kubectl delete -f config-map-secret.yaml
