NAME = robbertkl/roundcube

all:: build

build:
	docker build --rm --tag=$(NAME) .

push:
	docker push $(NAME)

shell:
	docker run --interactive --rm --tty $(NAME) /bin/bash
