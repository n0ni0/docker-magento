#!/bin/bash

printf "${GREEN}Restarting php container ${GREEN}\n"
docker restart $(docker ps -q --filter='name=php_')

