#!/bin/bash

rm -rif src/_build/html
cd src
export BASE_URL="/pygmt-howto-jp" 
myst build --html
cd ..
touch src/_build/html/.nojekyll
rsync -av --delete src/_build/html/ ./docs/ 
