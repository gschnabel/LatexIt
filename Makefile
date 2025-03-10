SED = $(shell which gsed >/dev/null 2>&1 && echo gsed || echo sed)
EXCLUDES = $(addprefix --exclude , $(shell find . -iname '.*.sw*'))

all: debug_template dist

release: release_template dist

dist:
	rm -f tblatex.xpi
	zip tblatex.xpi $(EXCLUDES) --exclude Makefile --exclude TODO --exclude icon.xcf --exclude install.rdf.template --exclude tblatex.xpi -r *

upload:
	echo "cd jonathan/files\nput tblatex.xpi\nput TODO TODO_tblatex\nput Changelog Changelog_tblatex" | ftp xulforum@ftp.xulforum.org

debug_template:
	cp -f install.rdf.template install.rdf
	$(SED) -i s/__REPLACEME__/\.$(shell date +%y%m%d)pre/ install.rdf

release_template:
	cp -f install.rdf.template install.rdf
	$(SED) -i s/__REPLACEME__// install.rdf
