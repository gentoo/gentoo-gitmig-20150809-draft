# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/lopster/lopster-0.9.6.ebuild,v 1.2 2001/05/01 18:29:06 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Napster Client using GTK"
SRC_URI="http://download.sourceforge.net/lopster/${A}"
HOMEPAGE="http://lopster.sourceforge.net"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=x11-libs/gtk+-1.2.8
        virtual/x11"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS BUGS COPYING README ChangeLog NEWS
}

