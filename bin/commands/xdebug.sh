#!/bin/bash

if [ "$1" == "disable" ]; then
  $COMMANDS_DIR/cli.sh sed -i -e 's/^zend_extension/\;zend_extension/g' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
  $COMMANDS_DIR/restart.sh
  printf "${GREEN}Xdebug has been disabled${COLOR_RESET}\n"
elif [ "$1" == "enable" ]; then
  $COMMANDS_DIR/cli.sh sed -i -e 's/^\;zend_extension/zend_extension/g' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
  $COMMANDS_DIR/restart.sh
  printf "${GREEN}Xdebug has been enabled${COLOR_RESET}\n"
else
  printf "${YELLOW}Please specify either 'enable' or 'disable' as an argument${COLOR_RESET}\n"
fi
