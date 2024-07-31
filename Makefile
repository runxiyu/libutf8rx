include ./config.mk

AWK = awk
UNICODE = https://unicode.org/Public/UCD/latest/ucd/UnicodeData.txt

OBJ =\
	fgetrune.o\
	fputrune.o\
	isalnumrune.o\
	isalpharune.o\
	isblankrune.o\
	iscntrlrune.o\
	isdigitrune.o\
	isgraphrune.o\
	isprintrune.o\
	ispunctrune.o\
	isspacerune.o\
	istitlerune.o\
	isxdigitrune.o\
	lowerrune.o\
	rune.o\
	runetype.o\
	upperrune.o\
	utf.o\
	utftorunestr.o

default: libutf8rx.a

libutf8rx.a: $(OBJ)
	$(AR) $(ARFLAGS) $@ $?
	$(RANLIB) $@

objects: $(OBJ)

update:
	@echo Downloading and parsing $(UNICODE)
	@curl -\# $(UNICODE) | $(AWK) -f mkrunetype.awk


.c.o:
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	$(RM) $(OBJ) libutf8rx.a
