# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.8.10.ebuild,v 1.2 2000/11/02 08:31:54 achim Exp $

P=Eterm-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A vt102 terminal emulator for X"
SRC_URI="ftp://eterm.sourceforge.net/pub/eterm/${A}"
HOMEPAGE="http://eterm,sourceforge.net"

DEPEND=">=sys-libs/glibc-2.1.3
	>=media-libs/imlib-1.9.8.1
	>=x11-base/xfree-4.0.1"

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

