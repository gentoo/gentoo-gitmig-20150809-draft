# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.6.ebuild,v 1.1 2001/07/03 15:42:38 g2boojum Exp $

#P=
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Bluefish is a GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${A}"
HOMEPAGE="http://bluefish.openoffice.nl/"

DEPEND=">=x11-libs/gtk+-1.2
        media-libs/imlib"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    mv Makefile Makefile.orig
    sed -e 's/$(datadir)/$(DESTDIR)$(datadir)/' \
        -e 's/$(pkgdatadir)/$(DESTDIR)$(pkgdatadir)/' \
        -e 's/$(pixmapsdir)/$(DESTDIR)$(pixmapsdir)/' \
	Makefile.orig > Makefile
    cd src
    mv Makefile Makefile.orig
    sed -e 's/$(bindir)/$(DESTDIR)$(bindir)/' \
	Makefile.orig > Makefile
    cd ..
    cd po
    mv Makefile Makefile.orig
    sed -e 's/$(datadir)/$(DESTDIR)$(datadir)/' \
        -e 's/$(gnulocaledir)/$(DESTDIR)$(gnulocaledir)/' \
        -e 's/$(localedir)/$(DESTDIR)$(localedir)/' \
	Makefile.orig > Makefile
    cd ..
    cd man
    mv Makefile Makefile.orig
    sed -e 's/$(mandir)/$(DESTDIR)$(mandir)/' \
	Makefile.orig > Makefile
    cd ..
    try make DESTDIR=${D} install
    dodoc ABOUT_NLS AUTHORS BUGS COPYING INSTALL NEWS README TODO

}

