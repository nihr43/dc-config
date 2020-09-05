.PHONY: lint

lint:
	find . -name "main.yml" | xargs yamllint -c yamllint.yml &&\
	ansible-lint main.yml
