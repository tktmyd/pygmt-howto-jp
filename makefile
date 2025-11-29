# makefile for pygmt-howto-jp

deploy:
	rm -rif src/_build/html
	cd src && myst build --html
	cd ..
	touch src/_build/html/.nojekyll
	rsync -av --delete src/_build/html/ ./docs/ 
