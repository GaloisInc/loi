-include Config.mk

all: build

.cabal-sandbox:
	cabal sandbox init

.PHONY: add-srcs
add-srcs: .cabal-sandbox
	cabal sandbox add-source $(PREFIX)/ivory \
                           $(PREFIX)/ivory-stdlib \
                           $(PREFIX)/ivory-serialize \
                           $(PREFIX)/ivory-opts \
                           $(PREFIX)/ivory-backend-c
ifeq ($(GHC),7.9)
	cabal sandbox add-source $(MYLANGC)/language-c-quote \
                           $(MYTHLIFT)/th-lift \
	                         $(MYHSSRCMETA)/haskell-src-meta \
                           $(MYTHORPHANS)/th-orphans \
                           $(MYPOLYPARSE)/polyparse-1.9 \
                           $(MYCMDLIB)/cmdlib-0.3.5 \
		                       $(MYFGL)/fgl-5.5.0.1
endif

.PHONY: build
build: add-srcs
ifeq ($(GHC),7.9)
	cabal install $(MYLANGC)/language-c-quote \
	              $(MYTHLIFT)/th-lift \
	              $(MYHSSRCMETA)/haskell-src-meta \
                $(MYTHORPHANS)/th-orphans \
                $(MYPOLYPARSE)/polyparse-1.9 \
                $(MYCMDLIB)/cmdlib-0.3.5 \
                $(MYFGL)/fgl-5.5.0.1
endif
	cabal install $(PREFIX)/ivory \
                $(PREFIX)/ivory-stdlib \
                $(PREFIX)/ivory-serialize \
                $(PREFIX)/ivory-opts \
                $(PREFIX)/ivory-backend-c


.PHONY: clean
clean:
	-rm -rf output
	-rm -f `find . -name '*.o'`
	-rm -f `find . -name '*.hi'`

.PHONY: veryclean
veryclean: clean
	-rm -rf .cabal-sandbox
