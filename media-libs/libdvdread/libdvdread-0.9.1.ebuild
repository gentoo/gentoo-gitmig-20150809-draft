# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/libdvdread-${PV}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

DEPEND="virtual/glibc
	>=media-libs/libdvdcss-0.0.3"

RDEPEND="$DEPEND"


src_compile() {

	./configure --prefix=/usr --mandir=/usr/share/man
	make || die
}

src_install () {
	
	make  DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	
}

