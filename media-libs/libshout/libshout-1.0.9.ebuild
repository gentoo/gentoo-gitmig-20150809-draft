# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-1.0.9.ebuild,v 1.5 2003/09/06 23:59:48 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libshout is a library for connecting and sending data to icecast servers."
SRC_URI="http://developer.icecast.org/libshout/releases/${P}.tar.gz"
HOMEPAGE="http://developer.icecast.org/libshout/"

SLOT="0"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"

DEPEND="sys-devel/gcc
	virtual/glibc"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}


