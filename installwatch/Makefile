# Makefile for installwatch
# $Id: Makefile,v 0.7.0.6 2008/11/09 07:49:34 izto Exp $

# Well, the only configurable part is the following variable.
# Make sure the directory you specify exists.

PREFIX=/usr/local
DESTDIR=

# End of configurable part

VERSION=0.7.0beta7

BINDIR=$(PREFIX)/bin
LIBDIR=$(PREFIX)/lib

LIBS       = -ldl
DEFINES    = -U_FORTIFY_SOURCE -D_GNU_SOURCE -DPIC -fPIC -D_REENTRANT -DVERSION=\"$(VERSION)\"
CFLAGS     = -Wall
ALL_CFLAGS = $(CFLAGS) $(DEFINES)

all: installwatch.so

installwatch.so: installwatch.o
	$(LD) $(LDFLAGS) -shared -o installwatch.so installwatch.o -ldl -lc

installwatch.o: installwatch.c localdecls.h
	$(CC) $(ALL_CFLAGS) -c installwatch.c

localdecls.h: create-localdecls
	./create-localdecls

install: all
	mkdir -p $(DESTDIR)$(LIBDIR)
	mkdir -p $(DESTDIR)$(BINDIR)
	if [ -r $(DESTDIR)$(LIBDIR)/installwatch.so ]; then \
		rm -f  $(DESTDIR)$(LIBDIR)/installwatch.so; \
	fi
	install -s installwatch.so $(DESTDIR)$(LIBDIR)
	
	sed -e "s|#PREFIX#|$(PREFIX)|" < installwatch > $(DESTDIR)$(BINDIR)/installwatch
	chmod 755 $(DESTDIR)$(BINDIR)/installwatch

uninstall:
	rm -f $(DESTDIR)$(LIBDIR)/installwatch.so
	rm -f $(DESTDIR)$(BINDIR)/installwatch
	
clean:
	rm -f *~ *.bak *.o installwatch.so core localdecls.h libctest test-installwatch

tarball: clean
	tar -czvC .. -f ../installwatch-$(VERSION).tar.gz installwatch-$(VERSION)

test: install
	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o test-installwatch test-installwatch.c $(LIBS)
	$(DESTDIR)$(PREFIX)/bin/installwatch ./test-installwatch


