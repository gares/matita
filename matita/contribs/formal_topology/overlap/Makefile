include ../../Makefile.defs

DIR=$(shell basename $$PWD)

$(DIR) all:
	$(BIN)../matitac
$(DIR).opt opt all.opt:
	$(BIN)../matitac.opt
clean:
	$(BIN)../matitaclean
clean.opt:
	$(BIN)../matitaclean.opt
depend:
	$(BIN)../matitadep -dot && rm depends.dot
depend.opt:
	$(BIN)../matitadep.opt -dot && rm depends.dot
