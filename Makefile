deploy:
	git push origin jekyll && cd _site && git add . && git commit -am "release" && git push origin master

build:
	jekyll --pygments --no-lsi

server:
	jekyll --server --auto

.PHONY: deploy build
