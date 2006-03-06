# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmusepack/libmusepack-1.1-r1.ebuild,v 1.4 2006/03/06 16:10:57 flameeyes Exp $

inherit autotools

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://files.musepack.net/source/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
