MAIN_FILE_BASE:=lecture_21
TEX?=pdflatex

define rm_all
	rm -f	${MAIN_FILE_BASE}.aux ${MAIN_FILE_BASE}.log ${MAIN_FILE_BASE}.out
	rm -f	${MAIN_FILE_BASE}.pdf ${MAIN_FILE_BASE}.toc
	rm -rf	_minted-${MAIN_FILE_BASE}
endef

${MAIN_FILE_BASE}.pdf: ${MAIN_FILE_BASE}.tex
	$(call rm_all)
	${TEX}	-shell-escape ${MAIN_FILE_BASE}.tex
	${TEX}	-shell-escape ${MAIN_FILE_BASE}.tex

.PHONY: clean
clean:
	$(call rm_all)
