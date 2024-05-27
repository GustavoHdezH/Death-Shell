#!/bin/bash
#
# Description: Delete images <none> and validate that images is not in use to delete it
# image_ids: Identifier Id for docker image.
# id: specifies that the ancestor of the conetainer must match the supplied image ID.
# example: sh drop_docker_images.sh
# Please delete comment and deploy on prodcution once all testing is complete
delete_images()
{
  image_ids=$(docker images | grep none | awk '{print $3}')
  # Verify if image is in use for a container
  for id in $image_ids; do
    in_use=$(docker ps -q --filter "ancestor=$id")
    if [ -n "$in_use" ]; then
      echo "La imagen $id está siendo utilizada y no se puede eliminar"
      continue # Jump to the next iteration of the loop
    fi
    # Try to delete the image
    output=$(docker rmi $id 2>&1)
      if echo "$output" | grep -q "Error: No such image"; then
          echo "No exite la imagen con el $id, debio borrarce en la ejecucion anterior"
      else
        echo "La imagen $id ha eliminada correctamente."
      fi
  done
  unset image_ids
  unset id
}
delete_images