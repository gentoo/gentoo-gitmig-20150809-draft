# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.26.ebuild,v 1.1 2000/11/26 20:54:17 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Converts Bitmaps to vector-grahics"
SRC_URI="http://homepages.go.com/homepages/m/a/r/martweb/${A}"
HOMEPAGE="http://homepages.go.com/homepages/m/a/r/martweb/AutoTrace.htm"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=x11-libs/gtkDPS-0.3.3
	>=x11-libs/gtk+-1.2.8
	>=x11-base/xfree-4.0.1"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
#    cp Makefile Makefile.orig
#    sed -e "s:\$(LINK):\$(LINK) -lXt:" Makefile.orig > Makefile
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README 
}

