#!/bin/bash

rm -rif src/_build/html
cd src
export BASE_URL="/pygmt-howto-jp" 
myst build --html --execute
cd ..
touch src/_build/html/.nojekyll
rsync -a --delete src/_build/html/ ./docs/ 

PUBLIC_URL='https://tktmyd.github.io/pygmt-howto-jp'   # 例: https://<user>.github.io/<repo>

sed -E -i.bak \
  "s|https?://localhost:[0-9]+|${PUBLIC_URL}|g" \
  docs/sitemap.xml
