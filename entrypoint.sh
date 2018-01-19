#!/bin/bash

REDIS_CONF=/etc/redis/redis.conf
REDIS_VERSION=4.0.6

if [[ $1 == 'start' ]]; then

        sed 's/daemonize yes/daemonize no/g' -i $REDIS_CONF
        sed 's/bind 127.0.0.1/bind 0.0.0./g' -i $REDIS_CONF
	sed 's/appendonly no/appendonly yes/g' -i $REDIS_CONF
	for file in `ls /etc/redis/conf.d/`;
	do echo "include /etc/redis/conf.d/$file" >> $REDIS_CONF;
	done
	
        echo "aaa"
	if [[ -s /var/lib/redis/appendonly.aof ]]; then
		echo "ccc"
		echo "y" | redis-check-aof --fix /var/lib/redis/appendonly.aof
		echo "ddd"
	fi
        echo "bbb"
        exec gosu redis /usr/bin/redis-server $REDIS_CONF
fi

if [[ -z $1 ]]; then
	entrypoint.sh start
fi
