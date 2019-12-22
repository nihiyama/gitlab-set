# if you use bash, "()" is replaced to "``".
# GITLAB_CONTAINER=(docker ps | grep gitlab-ce | awk -F " " '{print $$NF}')
# RUNNER_CONTAINER=(docker ps | grep runner | awk -F " " '{print $$NF}')

# Arguments for settings
args:
	$(eval GITLAB_CONTAINER := $(shell docker ps | grep gitlab-ce | awk -F " " '{print $$NF}'))
	$(eval RUNNER_CONTAINER := $(shell docker ps | grep runner | awk -F " " '{print $$NF}'))

# Initializing
# Use sleep to wait for gitlab initializing
pre_up:
	docker-compose up -d
	sleep 120

up: pre_up args
	docker exec -it \
	$(GITLAB_CONTAINER) \
	/bin/bash -c \
	"gitlab-rake db:migrate && \
	 gitlab-ctl reconfigure"

# Regist runner
runner_regist: args
	docker exec -it \
	$(RUNNER_CONTAINER) \
	/bin/bash -c \
	"gitlab-runner register --non-interactive \
	 --url http://$(GITLAB_CONTAINER)/ \
	 --registration-token ${TOKEN} \
	 --executor 'docker' \
	 --docker-image 'ubuntu' \
	 --docker-privileged"

