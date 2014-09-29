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
                           $(PREFIX)/ivory-backend-c \
                           $(PREFIX)/../language-c-quote

.PHONY: build
build: add-srcs
	cabal install $(PREFIX)/ivory \
                $(PREFIX)/ivory-stdlib \
                $(PREFIX)/ivory-serialize \
                $(PREFIX)/ivory-opts \
                $(PREFIX)/ivory-backend-c \
                $(PREFIX)/../language-c-quote


.PHONY: clean
clean:
	-rm -rf dist

.PHONY: veryclean
veryclean: clean
	-rm -rf .cabal-sandbox
