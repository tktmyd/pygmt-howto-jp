#!/bin/bash

#if [ -d src/_build ]; then
#    rm -rif src/_build
#fi
jb build src
touch src/_build/html/.nojekyll
rsync -av --delete src/_build/html/ ./docs/ 
