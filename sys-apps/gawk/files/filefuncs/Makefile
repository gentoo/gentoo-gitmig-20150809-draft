# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/files/filefuncs/Makefile,v 1.5 2005/01/14 13:25:15 eradicator Exp $

CC ?= gcc
LD = $(CC)

MAJORVER = 0
MINORVER = 0.1

AWKINCDIR = /usr/include/awk
DESTDIR =

TARGET = filefuncs.so.$(MAJORVER).$(MINORVER)

LIBDIR = lib

all: $(TARGET)

filefuncs.o: filefuncs.c
	$(CC) -shared -Wall -DHAVE_CONFIG_H -c -O2 -fPIC -I$(AWKINCDIR) $^

filefuncs.so.$(MAJORVER).$(MINORVER): filefuncs.o
	$(LD) -o $@ -shared -Wl,-soname -Wl,filefuncs.so.$(MAJORVER) $^

install: $(TARGET)
	install -m 0755 -d $(DESTDIR)/$(LIBDIR)/rcscripts
	install -m 0755 $(TARGET) $(DESTDIR)/$(LIBDIR)/rcscripts
	ldconfig -l $(DESTDIR)/$(LIBDIR)/rcscripts/$(TARGET)
	rm -f $(DESTDIR)/$(LIBDIR)/rcscripts/filefuncs.so
	ln -s $(TARGET) $(DESTDIR)/$(LIBDIR)/rcscripts/filefuncs.so

clean:
	rm -f $(TARGET)
	rm -f *.o *~ core
