#!/bin/bash
#
# Description: Automated tool to decrypt .gpg encrypted files.
# example: sh decrypt_files.sh /home/path/encryted_files /home/path/decrypted_files /home/path/passphrase.txt
# Note: To work, the tool requires the private key with which the file was created and the password (passphrase) associated with it.
# Please delete comment and deploy on prodcution once all testing is complete
get_paths(){
  filepath=$1
  output_dir=$2
  passphrasePath=$3
  export filepath output_dir passphrasePath
}
decrypt_massive_file(){
  local filepath=$1
  local output_dir=$2
  local passphrasePath=$3
  for FILE in "$filepath"/*.gpg; do
    gpg --verbose --output "${output_dir}/$(basename $FILE .gpg)" --decrypt --pinentry-mode loopback --passphrase-file $passphrasePath $FILE
  done
}
main(){
  decrypt_massive_file "$1" "$2" "$3"
}
main "$@"
