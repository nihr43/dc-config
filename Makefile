.PHONY: lint update apply

lint:
	find . -name "main.yml" | xargs yamllint -c yamllint.yml
