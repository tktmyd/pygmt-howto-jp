#!/bin/bash

cd $(dirname $0)
cd src
quarto render
cd ..
rsync -av --delete src/_site/ ./docs/
touch docs/.nojekyll
