all: update serve

serve: package.json
	npm run default

update:
	./update-resources.sh

init:
	gem install bundler
	bundle config --local set path 'vendor/bundle'
	bundle install --path vendor/bundle
