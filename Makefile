all: update package.json
	npm run default

update:
	./update-resources.sh

init:
	bundle install --path vendor/bundle
