#!/bin/bash
[ -z "$1" ] && echo "Please specify a CLI command (ex. ls)" && exit
docker-compose exec php "$@"
