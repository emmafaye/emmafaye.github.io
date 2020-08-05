#! /bin/bash

# Gets absolute window path using pwd and turning it into Windows-style syntax for the folder directory (needed by Docker)
DIR=$(echo "$PWD" | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/')

docker run -v "$DIR":/site bretfisher/jekyll new .