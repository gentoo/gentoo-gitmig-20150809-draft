# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-1.0.9.ebuild,v 1.13 2007/07/12 03:10:24 mr_bones_ Exp $

IUSE=""

DESCRIPTION="libshout is a library for connecting and sending data to icecast servers."
SRC_URI="http://developer.icecast.org/libshout/releases/${P}.tar.gz"
HOMEPAGE="http://developer.icecast.org/libshout/"

SLOT="0"
KEYWORDS="x86 sparc ~ppc"
LICENSE="GPL-2"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
