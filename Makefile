MAIN_FILE_BASE := main
MAIN_FILE_DEPS := compilation.tex preprocessor.tex nullptr.tex rvalue-references.tex smart-pointers.tex
HOW_TO_BASE := how-to-contribute
TEX_CMD ?= pdflatex

define clean_main_file
	rm -f	${MAIN_FILE_BASE}.aux $(MAIN_FILE_DEPS:%.tex=%.aux)
	rm -f	${MAIN_FILE_BASE}.log ${MAIN_FILE_BASE}.out
	rm -f	${MAIN_FILE_BASE}.pdf ${MAIN_FILE_BASE}.toc
	rm -f	${MAIN_FILE_BASE}-*.{asy,pdf,pre,tex}
	rm -rf	_minted-${MAIN_FILE_BASE}
endef

define clean_how_to_file
	rm -f	${HOW_TO_BASE}.aux
	rm -f	${HOW_TO_BASE}.log ${HOW_TO_BASE}.out
	rm -f	${HOW_TO_BASE}.pdf ${HOW_TO_BASE}.toc
	rm -rf	_minted-${HOW_TO_BASE}
endef

.PHONY: all
all: ${MAIN_FILE_BASE}.pdf ${HOW_TO_BASE}.pdf

${MAIN_FILE_BASE}.pdf: ${MAIN_FILE_BASE}.tex ${MAIN_FILE_DEPS}
	$(call clean_main_file)
	${TEX_CMD} --interaction=nonstopmode --halt-on-error --shell-escape ${MAIN_FILE_BASE}.tex
	find -name '${MAIN_FILE_BASE}-*.asy' -print0 | xargs -0 asy
	${TEX_CMD} --interaction=nonstopmode --halt-on-error --shell-escape ${MAIN_FILE_BASE}.tex
	${TEX_CMD} --interaction=nonstopmode --halt-on-error --shell-escape ${MAIN_FILE_BASE}.tex

${HOW_TO_BASE}.pdf: ${HOW_TO_BASE}.tex
	$(call clean_how_to_file)
	${TEX_CMD} --interaction=nonstopmode --halt-on-error --shell-escape ${HOW_TO_BASE}.tex
	${TEX_CMD} --interaction=nonstopmode --halt-on-error --shell-escape ${HOW_TO_BASE}.tex

.PHONY: clean
clean:
	$(call clean_main_file)
	$(call clean_how_to_file)
