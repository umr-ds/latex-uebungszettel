SOURCEFILES = base/exercise.cls
PDFLATEX = pdflatex -shell-escape --interaction=batchmode -halt-on-error

.PHONY: all clean

all: uebungen loesungen aufgaben
	
clean:
	rm -f u*.pdf u*.aux u*.log u*.out
	rm -f loesungen/l*.pdf loesungen/l*.aux loesungen/l*.log loesungen/l*.out
	rm -f aufgaben/*/*.aux aufgaben/*/*.pdf aufgaben/*/*.log aufgaben/*/*.out

# universal targets iterate through all source/u*.tex files and find their output counterparts
uebungen: $(foreach u, $(wildcard source/u*.tex), $(notdir $(subst .tex,.pdf, $u)))
loesungen: $(foreach u, $(wildcard source/u*.tex), $(subst source/u,loesungen/l, $(subst .tex,.pdf, $u)))
aufgaben: $(foreach a, $(wildcard aufgaben/*/*.tex), $(subst .tex,.pdf, $a))

# aufgaben pdfs are mady by passing the aufgaben filename to the stub tex file  
aufgaben/%.pdf: aufgaben/%.tex ${SOURCEFILES}
	echo $@
	AUFGABE=$(basename $@).tex $(PDFLATEX) -jobname=$(basename $@) base/stub.tex
	AUFGABE=$(basename $@).tex $(PDFLATEX) -jobname=$(basename $@) base/stub.tex
	@rm $(basename $@).aux $(basename $@).log $(basename $@).out

# uebungen pdfs are made by running pdflatex twice
u%.pdf : source/u%.tex aufgaben/*/*.tex ${SOURCEFILES}
	$(PDFLATEX) -jobname=$(basename $@) $<
	$(PDFLATEX) -jobname=$(basename $@) $<
	@rm $(basename $@).aux $(basename $@).log $(basename $@).out

# loesungen pdfs are made by setting SOLUTION env variable
loesungen/l%.pdf : source/u%.tex aufgaben/*/*.tex ${SOURCEFILES}
	mkdir -p loesungen
	SOLUTION=true $(PDFLATEX) -jobname=$(basename $@) $<
	SOLUTION=true $(PDFLATEX) -jobname=$(basename $@) $<
	@rm $(basename $@).aux $(basename $@).log $(basename $@).out