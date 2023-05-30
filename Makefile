.PHONY: clean lint env sync run
CONDA := $(or $(which mamba),mamba,conda)

#################################################################################
# COMMANDS                                                                      #
#################################################################################

## Create or update your conda environment
env: environment.yaml
	$(CONDA) env update -p ./envs -f environment.yaml --prune
	@echo
	@echo ">>> Activate your Conda Environment:"
	@echo "    $ conda activate ./envs"
	@echo

## Delete all compiled Python files
clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete

## Lint using ruff
lint:
	ruff src

## Sync to your data source
sync: data/proteometools/test.hdf5 data/ccs/meier_ccs.csv

data/proteometools/test.hdf5:
	mkdir -p data/proteometools
	wget -nc https://figshare.com/ndownloader/files/24635438
	mv 24635438 data/proteometools/test.hdf5

data/ccs/meier_ccs.csv:
	mkdir -p data/ccs
	wget -nc https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-021-21352-8/MediaObjects/41467_2021_21352_MOESM6_ESM.zip
	unzip 41467_2021_21352_MOESM6_ESM.zip
	mv SourceData_Figure_4.csv data/ccs/meier_ccs.csv
	rm -r 41467_2021_21352_MOESM6_ESM.zip SourceData_Figure_1.csv



#################################################################################
# PROJECT RULES                                                                 #
# Here is where project specific Make targets should be defined.				#
#################################################################################

## Regenerate your analyses
run:
	@echo "Add the steps of your analysis to this rule."

#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
