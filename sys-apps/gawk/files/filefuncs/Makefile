# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/files/filefuncs/Makefile,v 1.1 2003/03/25 15:27:34 azarah Exp $

CC = gcc
LD = gcc
MAJORVER = 0
MINORVER = 0.1
DESTDIR =

TARGET = filefuncs.so.$(MAJORVER).$(MINORVER)

all: $(TARGET)

filefuncs.o: filefuncs.c
	$(CC) -shared -Wall -DHAVE_CONFIG_H -c -O2 -fPIC -I/usr/include/awk $^

filefuncs.so.$(MAJORVER).$(MINORVER): filefuncs.o
	$(LD) -o $@ -shared -Wl,-soname -Wl,filefuncs.so.$(MAJORVER) $^

install: $(TARGET)
	install -m 0755 -d $(DESTDIR)/lib/rcscripts
	install -m 0755 $(TARGET) $(DESTDIR)/lib/rcscripts
	ldconfig -l $(DESTDIR)/lib/rcscripts/$(TARGET)
	rm -f $(DESTDIR)/lib/rcscripts/filefuncs.so
	ln -s $(TARGET) $(DESTDIR)/lib/rcscripts/filefuncs.so

clean:
	rm -f $(TARGET)
	rm -f *.o *~ core

