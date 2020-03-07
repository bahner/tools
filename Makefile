#!/usr/bin/make

FILES = aws-env-update ip-ranges.py p
BINDIR ?= ${HOME}/bin

install:
	mkdir -p $(BINDIR)
	chmod +x $(FILES)
	cp -p $(FILES) $(BINDIR)
