NS = jiramot
VERSION ?= 1.11.2

REPO = nginx
NAME = nginx
INSTANCE = default
PORTS = -p 80:80 -p 443:443

.PHONY: build push shell run start stop rm release

build:
	docker build -t $(NS)/$(REPO):$(VERSION) .

push:
	docker push $(NS)/$(REPO):$(VERSION)
	docker tag $(NS)/$(REPO):$(VERSION) $(NS)/$(REPO)
	docker push $(NS)/$(REPO)

shell:
	docker run --rm --name $(NAME)-$(INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

start:
	docker run -d --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

stop:
	docker stop $(NAME)-$(INSTANCE)

rm:
	docker rm -f $(NAME)-$(INSTANCE)

logs:
	docker logs $(NAME)-$(INSTANCE)

release: build
	make push -e VERSION=$(VERSION)

default: build
