postgresql['enable'] = false
gitlab_rails['db_username'] = "gitlab"
gitlab_rails['db_password'] = "gitlab"
gitlab_rails['db_host'] = "postgresql"
gitlab_rails['db_port'] = "5432"
gitlab_rails['db_database'] = "gitlabhq_production"
gitlab_rails['db_adapter'] = 'postgresql'
gitlab_rails['db_encoding'] = 'utf8'
redis['enable'] = false
gitlab_rails['redis_host'] = 'redis'
gitlab_rails['redis_port'] = '6379'
gitlab_rails['time_zone'] = 'Asia/Tokyo'
gitlab_rails['gitlab_shell_ssh_port'] = 30022
external_url 'http://gitlab/'
nginx['enabel'] = false
web_server['external_users'] = ['nginx']
web_server['username'] = 'nginx'