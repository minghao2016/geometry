GEOMETRY_VERSION=$(shell grep Version pkg/DESCRIPTION | perl -p -e "s/Version: //;")
GEOMETRY_SVN_REVISION=$(shell svn info -R | grep "Revision:" | perl -p -e 's/Revision: //;' | sort -n -r | head -1)
GEOMETRY_SVN_REVISION1=$(shell echo $(GEOMETRY_SVN_REVISION) + 1 | bc) 
PACKAGE=geometry_$(GEOMETRY_VERSION).tar.gz
QHULL_DIR=qhull-2012.1

roxygen:
	rm -f pkg/man/*
	echo "if (!library(roxygen2, logical.return=TRUE)) {install.packages(\"roxygen2\", repos=\"http://star-www.st-andrews.ac.uk/cran/\"); library(roxygen2) } ; roxygenize(\"pkg\")" |	R --no-restore --slave

package: roxygen
	rm -f pkg/R/*~
	R CMD build pkg

install: package
	R CMD INSTALL --latex $(PACKAGE) 

doc: roxygen
	rm -f geometry.pdf
	R CMD Rd2dvi --pdf --output=geometry.pdf pkg 

check: package
	#	echo "install.packages(c(\"rgl\",\"R.matlab\", \"tripack\", \"geometry\"), repos=\"http://star-www.st-andrews.ac.uk/cran/\")" |	R --no-restore --slave
	R CMD check --as-cran $(PACKAGE)
	@ if [ $$(/bin/ls -1 pkg/inst/doc/*htm 2>/dev/null | wc -l) -gt 0 ] ; then echo "ERROR: .htm files in pkg/inst/doc. See Makefile for suggestion of how to fix" ; fi	
	@ if [ $$(/bin/ls -1 pkg/inst/doc/html/*htm 2>/dev/null | wc -l) -gt 0 ]; then echo "ERROR: .htm files in pkg/inst/doc. See Makefile for suggestion of how to fix" ; fi 

revision:
	@echo $(GEOMETRY_SVN_REVISION)
	@echo $(GEOMETRY_SVN_REVISION1)


## qhull doc files need to have html suffixes and to have html 
htmldoc:
	cp $(QHULL_DIR)/index.htm pkg/inst/doc/index.html
	for f in  $(QHULL_DIR)/html/*.htm ; do cp $$f pkg/inst/doc/html/`basename $${f} .htm`.html ; done	
	cp $(QHULL_DIR)/html/*.gif pkg/inst/doc/html/
	perl -p -i -e 's/\.htm([#\"])/.html\1/g;' pkg/inst/doc/index.html	pkg/inst/doc/html/*.html
	perl -p -i -e 's|<head>|<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>|g;' pkg/inst/doc/index.html	pkg/inst/doc/html/*.html
	tidy -config tidy-config -f tidy-error.log -m pkg/inst/doc/index.html	pkg/inst/doc/html/*.html

## for f in  *.htm ; do svn move $f ${f}l ; done
## 
## cd html
## for f in  *.htm ; do svn move $f ${f}l ; done
## perl -p -i -e 's/\.htm([#\"])/.html\1/g; ' *.html

## Generate test results like this:
## R --vanilla < pkg/tests/delaunayn.R > pkg/tests/delaunayn.Rout.save

