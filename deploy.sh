#!/bin/bash

jb build src
touch src/_build/html/.nojekyll
rsync -av --delete src/_build/html/ ./docs/ 
