ifndef MANDIR
	MANDIR = share/man/man8
endif
ifndef PREFIX
	PREFIX = /usr/local
endif
ifndef CC
	CC     = gcc
endif
ifndef INSTALL
	INSTALL = /bin/install
endif

SRCS = bozohttpd.c auth-bozo.c cgi-bozo.c content-bozo.c daemon-bozo.c dir-index-bozo.c ssl-bozo.c tilde-luzah-bozo.c
OBJ  = bozohttpd

all: bozohttpd

bozohttpd:
	$(CC) $(CFLAGS) -o $(OBJ) $(SRCS) -lssl -lcrypto

clean:
	rm -f $(OBJ)
	rm -f *~

install::	bozohttpd
	mkdir -p $(PREFIX)/bin
	$(INSTALL) -s -m 755 $(OBJ) $(PREFIX)/bin
	$(INSTALL) -d $(PREFIX)/$(MANDIR)
	$(INSTALL) -m 644 $(OBJ).8 $(PREFIX)/$(MANDIR)

uninstall::
	-rm -f $(PREFIX)/bin/$(OBJ)
	-rm -f $(PREFIX)/$(MANDIR)/$(OBJ).8
