bindir = /bin
mandir = /usr/share/man

RM = rm -f
LN_S = ln -s

all: setarch links

setarch.i: setarch.c
	$(CC) $(CFLAGS) -E $< -o $@
links: setarch.i Makefile
	LC_ALL=C sed -n '/{PER_LINUX.*} ,$$/{s:[^"]*, ::;s:,.*::;s:"::g;p}' $< > links

install: setarch
	mkdir -p $(DESTDIR)$(bindir) $(DESTDIR)$(mandir)/man8
	install -m755 setarch $(DESTDIR)$(bindir)
	install -m644 setarch.8 $(DESTDIR)$(mandir)/man8
	for x in `cat links` ; do \
		$(LN_S) setarch $(DESTDIR)$(bindir)/$$x || exit 1 ; \
		$(LN_S) setarch.8 $(DESTDIR)$(mandir)/man8/$$x || exit 1 ; \
	done

clean:
	$(RM) setarch setarch.i links
