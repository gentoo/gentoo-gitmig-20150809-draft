# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-1.0.9.ebuild,v 1.11 2005/02/26 21:50:56 jnc Exp $

IUSE=""

DESCRIPTION="libshout is a library for connecting and sending data to icecast servers."
SRC_URI="http://developer.icecast.org/libshout/releases/${P}.tar.gz"
HOMEPAGE="http://developer.icecast.org/libshout/"

SLOT="0"
KEYWORDS="x86 sparc ~ppc"
LICENSE="GPL-2"

DEPEND="sys-devel/gcc
	virtual/libc"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}


