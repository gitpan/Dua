#
# Makefile to generate dua library
#

MYFUNC = dua
MYLIB= lib$(MYFUNC).a
OBJS = $(MYFUNC).o

.PRECIOUS: $(MYLIB)

PERLINCL= -I/bham/pd/packages/perl5/lib/sun4-solaris/5.002/CORE
INCLUDES= -I/bham/pd/packages/ldap/include $(PERLINCL)
DEFINES= -O -Kpic -DSVR4
CFLAGS= $(DEFINES) $(INCLUDES)

all: $(MYLIB) 

$(MYLIB): $(OBJS)
	ar cr $@ $(OBJS)

$(MYFUNC).o: $(MYFUNC).c

tidy:
	rm -f core *.o *~

clean: tidy
	rm -f $(MYLIB)
