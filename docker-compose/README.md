# doker-compose

- `services.gitlab.volumes`
  - `./data` -> `PATH_TO/data`
  - `./logs` -> `PATH_TO/logs`
  - `./config` -> `PATH_TO/config`
- `services.redis.volumes`
  - `./redis` -> `PATH_TO/redis`
- `sevices.postgresql.volumes`
  - `./postgresql/data` -> `PATH_TO/postgresql/data`

## Operate GitLab

### Initialize GitLab

1. `make up`

### Regist gitlab-runner

1. Take token `XXXXXXXXXX` from your repository
2. `make TOKEN=XXXXXXXXXX regist`
