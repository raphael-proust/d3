include ../Makefile.common


####


MLS=d3.ml d3m.ml
MLIS=$(MLS:ml=mli)
CMIS=$(MLS:ml=cmi)
CMOS=$(MLS:ml=cmo)



####


all: $(CMOS)

$(CMOS): $(CMIS)

%.cmo: %.ml
	$(OCAMLC) -g -c $<

%.cmi: %.mli
	$(OCAMLC) -g -c $<



clean:
	rm -f *.cm[ioa] *.so *.a a.out $(CMOS) $(CMIS)

