MAIN_FILE_BASE := main
TEX_CMD ?= pdflatex

define rm_all
	rm -f	*.aux
	rm -f	${MAIN_FILE_BASE}.log ${MAIN_FILE_BASE}.out
	rm -f	${MAIN_FILE_BASE}.pdf ${MAIN_FILE_BASE}.toc
	rm -rf	_minted-${MAIN_FILE_BASE}
endef

${MAIN_FILE_BASE}.pdf: ${MAIN_FILE_BASE}.tex compilation.tex nullptr.tex rvalue-references.tex
	$(call rm_all)
	${TEX_CMD} --shell-escape ${MAIN_FILE_BASE}.tex
	${TEX_CMD} --shell-escape ${MAIN_FILE_BASE}.tex

.PHONY: clean
clean:
	$(call rm_all)
