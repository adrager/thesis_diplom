# ---------------------------------------------------------------------------------
# Makefile
# $Id: makefile,v 1.1.1.1 2012/02/04 22:41:27 matsch Exp $
SOURCES = *.tex #*.bib figures/*

# Default: Compile texfiles
thesis.pdf: $(SOURCES)

	pdflatex thesis.tex
	bibtex thesis
	pdflatex thesis.tex

	@while ( grep "Rerun to get cross-references" Thesis.log > /dev/null ); do \
		echo '\n Re-running LaTeX to get cross-references \n'; \
		pdflatex Thesis.tex; \
	done

	@if ( grep "LaTeX Warning: Reference" Thesis.log > /dev/null ); then \
		echo '\nUndefined references'; \
		grep "LaTeX Warning: Reference" Thesis.log; \
	fi

	@if ( grep "LaTeX Warning: Citation" Thesis.log > /dev/null ); then \
		echo '\nUndefined citations'; \
		grep "LaTeX Warning: Citation" Thesis.log; \
	fi

	rm ./*.toc ./*.log ./*.out

# Clean up
clean:
	rm ./*.aux ./*.toc ./*.log ./*.out ./*~
