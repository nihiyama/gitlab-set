# if you use bash, "()" is replaced to "``".
# GITLAB_CONTAINER=(docker ps | grep gitlab-ce | awk -F " " '{print $$NF}')
# RUNNER_CONTAINER=(docker ps | grep runner | awk -F " " '{print $$NF}')

# Arguments for settings
args:
	$(eval GITLAB_CONTAINER := $(shell docker ps | grep gitlab-ce | awk -F " " '{print $$NF}'))
	$(eval RUNNER_CONTAINER := $(shell docker ps | grep runner | awk -F " " '{print $$NF}'))
	$(eval GITLAB_IP := $(shell docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(GITLAB_CONTAINER)))
	$(eval NETWORK := $(shell docker network ls | grep gitlab | awk -F " " '{print $$2}'))
	$(eval MGR_IP := $(shell hostname -i))

# swarm on
swarm: args
	docker swarm init --advertise-addr MGR_IP --listen-addr MGR_IP:2377; \


# Initializing
# Use sleep to wait for gitlab initializing
pre_up: 
	docker stack deploy --compose-file docker-compose.yml gitlab
	sleep 80

up: pre_up args
	docker exec -it \
	$(GITLAB_CONTAINER) \
	/bin/bash -c \
	"useradd nginx && \
	 usermod -aG git nginx && \
	 chmod g+rx /var/opt/gitlab/gitlab-rails/sockets/ && \
	 gitlab-rake db:migrate && \
	 gitlab-ctl reconfigure"

# Regist runner
regist: args
    for runner in $(RUNNER_CONTAINER); do \
	docker exec -it \
    $$runner \
    /bin/bash -c \
    "gitlab-runner register --non-interactive \
     --url http://gitlab/ \
     --clone-url http://gitlab/ \
     --registration-token ${TOKEN} \
     --executor 'docker' \
     --docker-dns '8.8.8.8' \
     --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
     --docker-image 'docker:stable' \
     --docker-network-mode '$(NETWORK)' \
     --docker-privileged"; \
    done

