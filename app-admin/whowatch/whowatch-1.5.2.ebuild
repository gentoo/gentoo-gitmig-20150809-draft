# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.5.2.ebuild,v 1.2 2001/07/15 18:15:46 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="an interactive who-like program that displays information
about the users currently logged on to the machine, in real time."
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${A}"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"

DEPEND="virtual/glibc sys-libs/ncurses"

src_unpack() {
   unpack ${A}
   cd ${S}
   try patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr mandir=${D}/usr/share/man install
    dodoc AUTHORS ChangeLog COPYING KEYS NEWS README TODO VERSION
}

