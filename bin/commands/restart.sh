#!/bin/bash

echo "Restarting php container with id: "
docker restart $(docker ps -q --filter='name=php_')

