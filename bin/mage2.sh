#!/bin/bash

resolve_dir()
{
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  done
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
}

init_dirs()
{
  resolve_dir
  export m2_DIR="${DIR}"
  export COMMANDS_DIR="${DIR}/commands"
  export PROPERTIES_DIR="${DIR}/properties"
}


init_dirs

COMMAND_NAME="$1.sh"
if [ ! -f ${COMMANDS_DIR}/${COMMAND_NAME} ]; then
    printf "${RED}Command not found${COLOR_RESET}\n"
    exit 1
fi

shift
${COMMANDS_DIR}/${COMMAND_NAME} "$@"
