# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.8.10.ebuild,v 1.1 2000/10/18 17:25:07 achim Exp $

P=Eterm-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A vt102 terminal emulator for X"
SRC_URI="ftp://eterm.sourceforge.net/pub/eterm/${A}"
HOMEPAGE="http://eterm,sourceforge.net"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} \
	--with-imlib
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc COPYING ChangeLog README ReleaseNotes
    dodoc bg/README.backgrounds
}

