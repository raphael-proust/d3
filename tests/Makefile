include ../Makefile.common


####


MLS=test.ml
BYTES=$(MLS:ml=byte)
TARGETS=$(MLS:ml=js)
LIB=../src/d3.cmo


####


all: $(TARGETS)

%.js: %.byte
	$(JOO) -pretty $<

%.byte: %.ml $(LIB)
	$(OCAMLC) -linkpkg -o $@ -I ../src $(LIB) $<

clean:
	rm -f *.cm[io] $(BYTES) $(TARGETS)


