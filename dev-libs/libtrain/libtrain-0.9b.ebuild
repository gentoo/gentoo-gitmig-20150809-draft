# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtrain/libtrain-0.9b.ebuild,v 1.3 2002/08/14 11:52:27 murphy Exp $

DESCRIPTION="Library for calculating fastest train routes"
SRC_URI="http://www.on.rim.or.jp/~katamuki/software/train/${P}.tar.gz"
HOMEPAGE="http://www.on.rim.or.jp/~katamuki/software/train/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
