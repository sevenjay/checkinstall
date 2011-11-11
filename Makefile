# $Id: Makefile,v 1.6.2.1 2008/11/09 07:48:18 izto Exp $

# Where to install.
DESTDIR=
PREFIX=/usr/local
BINDIR=$(PREFIX)/sbin
LCDIR=$(PREFIX)/share/locale
CONFDIR=/etc

all:
	for file in locale/checkinstall-*.po ; do \
		case $${file} in \
			locale/checkinstall-template.po)  ;; \
			*) \
				out=`echo $$file | sed -s 's/po/mo/'` ; \
				msgfmt -o $${out} $${file} ; \
				if [ $$? != 0 ] ; then \
					exit 1 ; \
				fi ; \
			;; \
		esac ; \
	done	
	$(MAKE) -C installwatch
	
install: all checkinstall checkinstallrc-dist
	export
	$(MAKE) -C installwatch install
	
	mkdir -p $(DESTDIR)$(BINDIR)
	install checkinstall makepak $(DESTDIR)$(BINDIR)
	for file in locale/*.mo ; do \
		LANG=`echo $$file | sed -e 's|locale/checkinstall-||' \
			-e 's|\.mo||'` && \
		mkdir -p $(DESTDIR)$(LCDIR)/$${LANG}/LC_MESSAGES && \
		install $$file $(DESTDIR)$(LCDIR)/$${LANG}/LC_MESSAGES/checkinstall.mo || \
		exit 1 ; \
	done
	
	mkdir -p $(DESTDIR)$(CONFDIR)
	install -m644  checkinstallrc-dist $(DESTDIR)$(CONFDIR)
	if ! [ -f $(DESTDIR)$(CONFDIR)/checkinstallrc ]; then \
		install $(DESTDIR)$(CONFDIR)/checkinstallrc-dist $(DESTDIR)$(CONFDIR)/checkinstallrc; \
	else \
		echo; \
		echo; \
		echo ======================================================== ;\
		echo; \
		echo An existing checkinstallrc file has been found. ;\
		echo The one from this distribution can be found at: ; \
		echo; \
		echo -e \\t$(DESTDIR)$(CONFDIR)/checkinstallrc-dist ; \
		echo; \
		echo; \
		echo ======================================================== ;\
		echo; \
	fi

checkinstall: checkinstall.in
	sed -e 's%@TEXTDOMAINDIR@%$(LCDIR)%g' -e 's%@CONFDIR@%$(CONFDIR)%g' $< > $@

checkinstallrc-dist: checkinstallrc-dist.in
	sed -e 's%@PREFIX@%$(PREFIX)%g' $< >$@

clean:
	for file in locale/checkinstall-*.mo ; do \
		rm -f $${file} ; \
	done
	rm -f checkinstall checkinstallrc-dist
	$(MAKE) -C installwatch clean
