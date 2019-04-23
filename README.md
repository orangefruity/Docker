# docker-compose

Clone the docker-compose url and up the app
docker-compose up

root@multipurpose:~/Packer# docker-compose up
Creating network "packer_default" with the default driver
Creating packer_redis_1
Creating packer_app_1
Attaching to packer_redis_1, packer_app_1
redis_1  | 1:C 23 Apr 13:12:41.347 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
redis_1  | 1:C 23 Apr 13:12:41.348 # Redis version=4.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
redis_1  | 1:C 23 Apr 13:12:41.348 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
redis_1  | 1:M 23 Apr 13:12:41.348 * Running mode=standalone, port=6379.
redis_1  | 1:M 23 Apr 13:12:41.348 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
redis_1  | 1:M 23 Apr 13:12:41.348 # Server initialized
redis_1  | 1:M 23 Apr 13:12:41.348 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
redis_1  | 1:M 23 Apr 13:12:41.349 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
redis_1  | 1:M 23 Apr 13:12:41.349 * Ready to accept connections
app_1    |  * Serving Flask app "app.py" (lazy loading)
app_1    |  * Environment: development
app_1    |  * Debug mode: on
app_1    |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
app_1    |  * Restarting with stat
app_1    |  * Debugger is active!
app_1    |  * Debugger PIN: 133-052-127



Notes: use docker-compose up -d To Get into daemonized mode.


root@multipurpose:~/Packer# docker-compose stop
Stopping packer_app_1 ... done
Stopping packer_redis_1 ... done


root@multipurpose:~/Packer# docker-compose down
Stopping packer_app_1 ... done
Stopping packer_redis_1 ... done
Removing packer_app_1 ... done
Removing packer_redis_1 ... done
Removing network packer_default
root@multipurpose:~/Packer#


Scale up and Scale down
oot@multipurpose:~/Packer# docker-compose scale redis=4
Creating and starting packer_redis_2 ... done
Creating and starting packer_redis_3 ... done
Creating and starting packer_redis_4 ... done
root@multipurpose:~/Packer# docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                    NAMES
2ac1791ab1c3        redis:4.0.11-alpine          "docker-entrypoint.s…"   5 seconds ago       Up 3 seconds        6379/tcp                 packer_redis_4
7210d10b911d        redis:4.0.11-alpine          "docker-entrypoint.s…"   5 seconds ago       Up 4 seconds        6379/tcp                 packer_redis_3
6b0481b7bf84        redis:4.0.11-alpine          "docker-entrypoint.s…"   5 seconds ago       Up 3 seconds        6379/tcp                 packer_redis_2
e3ba2e43af56        takacsmark/flask-redis:1.0   "/bin/sh -c 'flask r…"   2 minutes ago       Up 2 minutes        0.0.0.0:5000->5000/tcp   packer_app_1
1bd1e48f22fe        redis:4.0.11-alpine          "docker-entrypoint.s…"   2 minutes ago       Up 2 minutes        6379/tcp                 packer_redis_1
root@multipurpose:~/Packer#


docker scale down
root@multipurpose:~/Packer# docker-compose scale redis=1
Stopping and removing packer_redis_2 ... done
Stopping and removing packer_redis_3 ... done
Stopping and removing packer_redis_4 ... done
root@multipurpose:~/Packer# docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                    NAMES
e3ba2e43af56        takacsmark/flask-redis:1.0   "/bin/sh -c 'flask r…"   3 minutes ago       Up 3 minutes        0.0.0.0:5000->5000/tcp   packer_app_1
1bd1e48f22fe        redis:4.0.11-alpine          "docker-entrypoint.s…"   3 minutes ago       Up 3 minutes        6379/tcp                 packer_redis_1
root@multipurpose:~/Packer#
