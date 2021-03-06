DOCKER_COMPOSE=APPDYNAMICS_AGENT_ACCOUNT_NAME=$(APPDYNAMICS_AGENT_ACCOUNT_NAME) APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=$(APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY) APPDYNAMICS_CONTROLLER_HOST_NAME=$(APPDYNAMICS_CONTROLLER_HOST_NAME) APPDYNAMICS_CONTROLLER_SSL_ENABLED=$(APPDYNAMICS_CONTROLLER_SSL_ENABLED) APPDYNAMICS_CONTROLLER_PORT=$(APPDYNAMICS_CONTROLLER_PORT) AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) docker-compose
DOCKER_RUN=$(DOCKER_COMPOSE) up -d --build
DOCKER_STOP=$(DOCKER_COMPOSE) down

dockerRun: ## Run MA in docker
	@echo starting container ##################%%%%%%%%%%%%%%%%%%%&&&&&&&&&&&&&&&&&&&&&&
	${DOCKER_RUN}
	@echo started container ##################%%%%%%%%%%%%%%%%%%%&&&&&&&&&&&&&&&&&&&&&&

dockerStop:
	${DOCKER_STOP}

sleep:
	@echo Waiting for 5 minutes to read the metrics
	sleep 300
	@echo Wait finished

terraformApply:
	@echo Download terraform
	#sudo mkdir terraform
	#cd terraform/
	sudo wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip -P terraform
	cd ./terraform
	ls
	sudo unzip terraform/terraform_0.11.11_linux_amd64.zip -d terraform
	@echo Terraform downloaded
	#cd ..
	#sudo mv main.tf ./terraform
	#cd terraform/
	echo access key ${AWS_ACCESS_KEY_ID}
	sudo terraform/terraform init
	#sudo terraform/terraform plan
	@echo Terraform initialised
	sudo TF_VAR_AWS_ACCESS_KEY="${AWS_ACCESS_KEY_ID}" TF_VAR_AWS_SECRET_KEY="${AWS_SECRET_ACCESS_KEY}"  terraform/terraform apply -auto-approve
	@echo Terraform setup done.

terraformDestroy:
	@echo Destroy instance
	sudo TF_VAR_AWS_ACCESS_KEY="${AWS_ACCESS_KEY_ID}" TF_VAR_AWS_SECRET_KEY="${AWS_SECRET_ACCESS_KEY}"  terraform/terraform destroy -auto-approve
	@echo Instance destroyed
	sudo rm -rf terraform
	@echo Terraform Removed