# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.5.2.ebuild,v 1.6 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="an interactive who-like program that displays information
about the users currently logged on to the machine, in real time."
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"
LICENSE="GPL-2"

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

