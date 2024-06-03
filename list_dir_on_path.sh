#!/bin/bash
#
# Description: Generates a list of directories that are in a specific path
# example: sh list_dir_on_path.sh /home/user/path/remote
# Please delete comment and deploy on prodcution once all testing is complete
path_remote=$1
check_input_data_arguments(){
  if [ -z "$1" ]; then
    echo "Se debe colocar la ruta destino a listar como argumento"
    exit 1
  fi
  if [ ! -e "$path_remote" ]; then
    echo "Ingresa una ruta valida"
    exit 1
  fi
}

list_folders_on_remote_path(){
  find "$path_remote" -maxdepth 1 -type d | xargs -n 1 basename  >> dir_on_path.txt
}

main(){
  check_input_data_arguments "$1"
  list_folders_on_remote_path "$1"
  unset path_remote
}

main "$@"
