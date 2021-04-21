# Thesis
THESIS_ALL_TEX= $(wildcard *.tex)
DEFAULT_TARGET= whole_thesis
DEFAULT_PDF= thesis.pdf
COMPILE_SLIDES := xelatex -shell-escape

default: $(DEFAULT_TARGET)
all: whole_thesis \
     chapter_introduction chapter_conclusion

thesis.pdf: whole_thesis

figures:
	echo "\n\n\n\n\n\n\n" | emacs -batch \
		--eval "(require 'package)" \
		--eval "(package-initialize)" \
		--eval "(setq enable-local-eval t)" \
		--eval "(setq enable-local-variables t)" \
		--eval "(org-babel-do-load-languages 'org-babel-load-languages '((shell . t) (python . t) (R . t)))" \
		--eval "(setq org-export-babel-evaluate t)" \
		--eval "(setq org-confirm-babel-evaluate nil)" \
		figures.org \
		--funcall org-babel-execute-buffer

# Compile the whole thesis
whole_thesis: $(THESIS_ALL_TEX) Makefile references.bib
	cp macros.include.default.tex macros.include.tex
	pdflatex -shell-escape thesis.tex
	biber thesis.bcf
	pdflatex -shell-escape thesis.tex
	pdflatex -shell-escape thesis.tex

############################
# Only compile one chapter #
############################
chapter_introduction: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterintroduction {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	rubber --pdf --unsafe -Wall --jobname $@ thesis.tex

chapter_conclusion: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterconclusion {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	rubber --pdf --unsafe -Wall --jobname $@ thesis.tex

chapter_prediction: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterprediction {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	rubber --pdf --unsafe -Wall --jobname $@ thesis.tex

chapter_experiment: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterexperiment {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	rubber --pdf --unsafe -Wall --jobname $@ thesis.tex

chapter_appendix: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterappendix {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	rubber --pdf --unsafe -Wall --jobname $@ thesis.tex

#########################
# Convenience shortcuts #
#########################

check_missing_refs_no_rebuild:
	tools/check_missing_refs.py -d .

check_missing_refs: whole_thesis check_missing_refs_no_rebuild

check_unreferenced_labels:
	tools/check_unreferenced_labels.bash *.tex

check_uncited_references:
	tools/check_uncited_references.bash references.bib *.tex

# View shortcuts
view:
	llpp $(DEFAULT_PDF) &

update-view:
	@killall -SIGHUP llpp &> /dev/null || true # update pdf viewer


############
# Slides   #
############

# Create a PDF with a white pages
# Used to generate the summary slide
# Old way to do it, broken because of imagemagick security policy: @convert xc:none -page Letter /tmp/empty.pdf
/tmp/empty.pdf:
	@echo "JVBERi0xLjQgCjEgMCBvYmoKPDwKL1BhZ2VzIDIgMCBSCi9UeXBlIC9DYXRhbG9nCj4+CmVuZG9iagoyIDAgb2JqCjw8Ci9UeXBlIC9QYWdlcwovS2lkcyBbIDMgMCBSIF0KL0NvdW50IDEKPj4KZW5kb2JqCjMgMCBvYmoKPDwKL1R5cGUgL1BhZ2UKL1BhcmVudCAyIDAgUgovUmVzb3VyY2VzIDw8Ci9YT2JqZWN0IDw8IC9JbTAgOCAwIFIgPj4KL1Byb2NTZXQgNiAwIFIgPj4KL01lZGlhQm94IFswIDAgNjEyIDc5Ml0KL0Nyb3BCb3ggWzAgMCA2MTIgNzkyXQovQ29udGVudHMgNCAwIFIKL1RodW1iIDExIDAgUgo+PgplbmRvYmoKNCAwIG9iago8PAovTGVuZ3RoIDUgMCBSCj4+CnN0cmVhbQpxCjEgMCAwIDEgMCAwIGNtCi9JbTAgRG8KUQoKZW5kc3RyZWFtCmVuZG9iago1IDAgb2JqCjI3CmVuZG9iago2IDAgb2JqClsgL1BERiAvVGV4dCAvSW1hZ2VDIF0KZW5kb2JqCjcgMCBvYmoKPDwKPj4KZW5kb2JqCjggMCBvYmoKPDwKL1R5cGUgL1hPYmplY3QKL1N1YnR5cGUgL0ltYWdlCi9OYW1lIC9JbTAKL0ZpbHRlciBbIC9SdW5MZW5ndGhEZWNvZGUgXQovV2lkdGggMQovSGVpZ2h0IDEKL0NvbG9yU3BhY2UgMTAgMCBSCi9CaXRzUGVyQ29tcG9uZW50IDgKL1NNYXNrIDE1IDAgUgovTGVuZ3RoIDkgMCBSCj4+CnN0cmVhbQoAAIAKZW5kc3RyZWFtCmVuZG9iago5IDAgb2JqCjMKZW5kb2JqCjEwIDAgb2JqCi9EZXZpY2VHcmF5CmVuZG9iagoxMSAwIG9iago8PAovRmlsdGVyIFsgL1J1bkxlbmd0aERlY29kZSBdCi9XaWR0aCAxCi9IZWlnaHQgMQovQ29sb3JTcGFjZSAxMCAwIFIKL0JpdHNQZXJDb21wb25lbnQgOAovTGVuZ3RoIDEyIDAgUgo+PgpzdHJlYW0KAACACmVuZHN0cmVhbQplbmRvYmoKMTIgMCBvYmoKMwplbmRvYmoKMTMgMCBvYmoKPDwKPj4KZW5kb2JqCjE0IDAgb2JqCjMKZW5kb2JqCjE1IDAgb2JqCjw8Ci9UeXBlIC9YT2JqZWN0Ci9TdWJ0eXBlIC9JbWFnZQovTmFtZSAvTWEwCi9GaWx0ZXIgWyAvUnVuTGVuZ3RoRGVjb2RlIF0KL1dpZHRoIDEKL0hlaWdodCAxCi9Db2xvclNwYWNlIC9EZXZpY2VHcmF5Ci9CaXRzUGVyQ29tcG9uZW50IDgKL0xlbmd0aCAxNiAwIFIKPj4Kc3RyZWFtCgAAgAplbmRzdHJlYW0KZW5kb2JqCjE2IDAgb2JqCjMKZW5kb2JqCjE3IDAgb2JqCjw8Ci9UaXRsZSAo/v8AZQBtAHAAdAB5AAApCi9DcmVhdGlvbkRhdGUgKEQ6MjAyMTA0MTAxMTIyMjQpCi9Nb2REYXRlIChEOjIwMjEwNDEwMTEyMjI0KQovUHJvZHVjZXIgKGh0dHBzOi8vaW1hZ2VtYWdpY2sub3JnKQo+PgplbmRvYmoKeHJlZgowIDE4CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAxMCAwMDAwMCBuIAowMDAwMDAwMDU5IDAwMDAwIG4gCjAwMDAwMDAxMTggMDAwMDAgbiAKMDAwMDAwMDMwMCAwMDAwMCBuIAowMDAwMDAwMzgwIDAwMDAwIG4gCjAwMDAwMDAzOTggMDAwMDAgbiAKMDAwMDAwMDQzNiAwMDAwMCBuIAowMDAwMDAwNDU3IDAwMDAwIG4gCjAwMDAwMDA2NTYgMDAwMDAgbiAKMDAwMDAwMDY3MyAwMDAwMCBuIAowMDAwMDAwNzAxIDAwMDAwIG4gCjAwMDAwMDA4NDYgMDAwMDAgbiAKMDAwMDAwMDg2NCAwMDAwMCBuIAowMDAwMDAwODg2IDAwMDAwIG4gCjAwMDAwMDA5MDQgMDAwMDAgbiAKMDAwMDAwMTA5NiAwMDAwMCBuIAowMDAwMDAxMTE0IDAwMDAwIG4gCnRyYWlsZXIKPDwKL1NpemUgMTgKL0luZm8gMTcgMCBSCi9Sb290IDEgMCBSCi9JRCBbPGFmNTU3MGY1YTE4MTBiN2FmNzhjYWY0YmM3MGE2NjBmMGRmNTFlNDJiYWY5MWQ0ZGU1YjIzMjhkZTBlODNkZmM+IDxhZjU1NzBmNWExODEwYjdhZjc4Y2FmNGJjNzBhNjYwZjBkZjUxZTQyYmFmOTFkNGRlNWIyMzI4ZGUwZTgzZGZjPl0KPj4Kc3RhcnR4cmVmCjEyNTcKJSVFT0YK" | base64 --decode > /tmp/empty.pdf

slides_old.pdf: slides.tex /tmp/empty.pdf
	@cp /tmp/empty.pdf slides_old.pdf
	@$(COMPILE_SLIDES) $<
	@mv slides.pdf slides_old.pdf

slides.pdf: slides.tex slides_old.pdf
	@$(COMPILE_SLIDES) $<
	@echo $@ has been updated

############
# cleaning #
############
clean:
	rm -f *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc *.upa *-blx.bib *.snm *.nav *.vrb
	rm -f macros.include.tex
	rm -rf svg-inkscape

distclean: clean
	rm -f thesis.pdf
	rm -f chapter*.pdf
	rm -f slides.pdf slides_old.pdf

mrproper: clean

# Disable parallel build
.NOTPARALLEL:
