# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.50.35.ebuild,v 1.1 2002/07/23 22:23:54 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="redhat's newt windowing toolkit development files"
SRC_URI="http://koto.mynetix.de/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.redhat.com"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-libs/slang-1.4
	>=dev-libs/popt-1.6"

RDEPEND=""

src_compile() {

	./configure 	--host=${CHOST} \
			--prefix=/usr || die "configure failure"
	emake || die "emake failure"
}

src_install () {

	make prefix=${D}/usr install || die "make install failed"
	dodoc CHANGES COPYING peanuts.py popcorn.py tutorial.sgml
}
