# gitlab-set

## Edit doker-compose.yml

- `services`
  - `gitlab`
    - `volumes`
      - `./data` -> `PATH_TO/data`
      - `./logs` -> `PATH_TO/logs`
      - `./config` -> `PATH_TO/config`
  - `redis`
    - `volumes`
      - `./redis` -> `PATH_TO/redis`
  - `postgresql`
    - `volumes`
      - `./volumes` -> `PATH_TO/var/lib/postgresql`

## Operate GitLab

### Initialize GitLab

1. `make initial_set`

### Start GitLab

1. `make start`

### Stop GitLab

1. `make stops`

### Regist gitlab-runner

1. Take token `XXXXXXXXXX` from your repository
2. `make TOKEN=XXXXXXXXXX runner_regist`
