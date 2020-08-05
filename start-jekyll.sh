#! /bin/bash

# Gets absolute window path using pwd and turning it into Windows-style syntax for the folder directory (needed by Docker)
DIR=$(echo "$PWD" | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/')
JEKYLL_VERSION=3.8

docker run --rm --label=jekyll --volume="$DIR"/src:/srv/jekyll  -it -p 4000:4000 jekyll/jekyll:pages jekyll serve

# docker run \
#   --env FORCE_POLLING=true \
#   --env JEKYLL_ENV=development \
#   --env VERBOSE=true \
#   --it jekyll/jekyll:$JEKYLL_VERSION \
#   --label=jekyll \
#   --tty \
#   --publish $(docker-machine ip jekyll):4000:80 \  
#   --rm \  
#   --volume="$DIR":/srv/jekyll jekyll/jekyll:pages \
#    jekyll build --watch