# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}.ogle2
DESCRIPTION="A portable abstraction library for DVD decryption"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/libdvdcss-${PV}.ogle2.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

DEPEND="virtual/glibc"

RDEPEND="$DEPEND"


src_compile() {

	./configure --prefix=/usr --mandir=/usr/share/man
	make || die
}

src_install () {
	
	make  DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

