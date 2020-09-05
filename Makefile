.PHONY: lint

lint:
	find . -name "main.yml" | xargs yamllint -c yamllint.yml &&\
	yamllint group_vars/* &&\
	ansible-lint main.yml
