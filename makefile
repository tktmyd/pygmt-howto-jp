# makefile for pygmt-howto-jp

preview:
	rm -rif src/_build/html
	jb build src
	open src/_build/html/index.html

deploy:
	rm -rif src/_build/html
	jb build src
	touch src/_build/html/.nojekyll
	rsync -av --delete src/_build/html/ ./docs/ 