
#SWIPLCMD= cgexec -g memory,cpuset:devprotection swipl -G1G -L1G -T1G -f "/home/wko/TUD/12. Semester/WHK SOL/pie_20170709/src/folelim/load.pl"
SWIPLCMD= swipl -G1G -L1G -T1G -f "pie_20170709/src/folelim/load.pl"

all: circ2

circ2: scratch_circ2.pl
	echo "ppl." | $(SWIPLCMD) -l scratch_circ2.pl
	#latexmk -cd -e -f -pdf -interaction=nonstopmode -synctex=1 "/tmp/tmp_ppl.tex"

bib:
	cp mybib.bib /tmp
	( cd /tmp && bibtex tmp_ppl.aux && pdflatex tmp_ppl.tex )

final: circ2 bib
	echo "ppl." | $(SWIPLCMD) -l scratch_circ2.pl
	( cd /tmp && pdflatex tmp_ppl.tex )
	cp /tmp/tmp_ppl.pdf On_Circumscription.pdf

interactive:
	$(SWIPLCMD) -l scratch_circ2.pl

bare:
	$(SWIPLCMD)

clean:
	rm /tmp/tmp_ppl.*

show: circ2
	open /tmp/tmp_ppl.pdf &
