export FIND_EXCLUDES = -not \( -name .terraform -prune \) -not \( -name .terragrunt-cache -prune \) -not \( -name vendor -prune \)

-include $(shell curl -sSL -o .tardigrade-ci "https://raw.githubusercontent.com/plus3it/tardigrade-ci/master/bootstrap/Makefile.bootstrap"; echo .tardigrade-ci)

clean::
	rm -rf vendor

VENDOR ?= vendor/github.com/awslabs/aws-config-rules
vendor: $(VENDOR)
	echo "root = true" > vendor/.editorconfig

vendor/%:
	git clone https://$(*).git vendor/$*
	rm -rf vendor/$*/.git
