include ../../Makefile.common


####


MLS=d3m.ml
MLIS=$(MLS:ml=mli)
CMIS=$(MLS:ml=cmi)
CMOS=$(MLS:ml=cmo)

BINDINGSDIR= -I ../bindings/



####


all: $(CMOS)

$(CMOS): $(CMIS)

%.cmo: %.ml
	$(OCAMLC) $(BINDINGSDIR) -g -c $<

%.cmi: %.mli
	$(OCAMLC) $(BINDINGSDIR) -g -c $<



clean:
	rm -f *.cm[ioa] *.so *.a a.out $(CMOS) $(CMIS)

