-include Config.mk

all: build

PACKAGES= \
	$(PREFIX)/ivory \
	$(PREFIX)/ivory-artifact \
	$(PREFIX)/ivory-stdlib \
	$(PREFIX)/ivory-serialize \
	$(PREFIX)/ivory-opts \
	$(PREFIX)/ivory-backend-c

PACKAGEDIRS=$(foreach p, $(PACKAGES), $(p)/)

GHC79EXTRAS= \
	$(MYLANGC)/language-c-quote \
	$(MYTHLIFT)/th-lift \
	$(MYHSSRCMETA)/haskell-src-meta \
	$(MYTHORPHANS)/th-orphans \
	$(MYPOLYPARSE)/polyparse-1.9 \
	$(MYCMDLIB)/cmdlib-0.3.5 \
	$(MYFGL)/fgl-5.5.0.1

GHC79EXTRADIRS=$(foreach p, $(GHC79EXTRADIRS), $(p)/)

.cabal-sandbox:
	cabal sandbox init

.PHONY: add-srcs
add-srcs: .cabal-sandbox
	cabal sandbox add-source $(PACKAGEDIRS)
ifeq ($(GHC),7.9)
	cabal sandbox add-source $(GHC79EXTRADIRS)
endif

.PHONY: build
build: add-srcs
ifeq ($(GHC),7.9)
	cabal install $(GHC79EXTRADIRS)
endif
	cabal install $(PACKAGEDIRS)

.PHONY: gen
gen:
	-cabal exec ghc LOI/LOI.hs
	-./LOI/LOI

.PHONY: clean
clean:
	-rm -rf output
	-rm -f LOI/LOI LOI/*.o LOI/*.hi Stanag/*.o Stanag/*.hi

.PHONY: veryclean
veryclean: clean
	-rm -rf .cabal-sandbox
