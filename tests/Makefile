include ../Makefile.common


####


MLS=barchart_lowlevel.ml barchart.ml interpolation.ml
BYTES=$(MLS:ml=byte)
TARGETS=$(MLS:ml=js)
LIB=../src/bindings/d3.cmo ../src/lib/d3m.cmo


####


all: $(TARGETS)

%.js: %.byte
	$(JOO) -pretty $<

%.byte: %.ml
	$(OCAMLC) \
	  -linkpkg -o $@ \
	  -I ../src/bindings -I ../src/lib \
	  $(LIB) $<

clean:
	rm -f *.cm[io] $(BYTES) $(TARGETS)


