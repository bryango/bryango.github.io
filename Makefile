all: update package.json
	npm run default

update:
	./update-resources.sh

init:
	gem install bundler
	bundle install --path vendor/bundle
