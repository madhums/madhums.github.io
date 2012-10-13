deploy:
	git push origin jekyll && cd _site && git add . && git commit -am "release" && git push origin master

.PHONY: deploy
