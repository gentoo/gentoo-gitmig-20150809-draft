# Copyright 1999-2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.1.ebuild,v 1.2 2002/06/17 18:50:57 lostlogic Exp $

DESCRIPTION="Library for DVD navigation tools."
HOMEPAGE="http://sourceforge.net/projects/dvd/"

SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"
S=${WORKDIR}/${P}

LICENSE="GPL"
SLOT="0"

DEPEND="media-libs/libdvdread"
RDEPEND="${DEPEND}"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README
}
