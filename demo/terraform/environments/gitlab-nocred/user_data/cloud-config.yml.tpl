#cloud-config

packages:
  - git
  - docker
  - vim

timezone: "Asia/Tokyo"

write_files:
- path: /etc/systemd/system/docker.service.d/override.apiVersion: v1
  permissions: 0755
  content: |
    [Service]
    Environment="DOCKER_NETWORK_OPTIONS=--dns 8.8.8.8"
    ExecStart=
    ExecStart=/usr/bin/dockerd -H fd:// $DOCKER_NETWORK_OPTIONS -H tcp://127.0.0.1:2375
  

runcmd:
  - systemctl enable docker
  - systemctl start docker
  - curl -L https://github.com/docker/compose/releases/download/1.25.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  - chmod +x /usr/local/bin/docker-compose
  - curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
  - curl -L https://raw.githubusercontent.com/docker/compose/1.25.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
  - docker pull nginx:1.13
  - docker pull redis:5.0.7-alpine
  - docker pull postgres:9.6-alpine
  - docker pull gitlab/gitlab-ce:latest
  - docker pull gitlab/gitlab-runner:alpine
  - mkdir -p /var/run/gitlab/gitlab/data \
    /var/run/gitlab/gitlab/logs \
    /var/run/gitlab/gitlab/config \
    /var/run/gitlab/postgresql/data \
    /var/run/gitlab/redis/data \
    /var/run/gitlab/gitlab-runner
  -
