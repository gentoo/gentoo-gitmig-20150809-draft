# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.4.ebuild,v 1.4 2002/08/14 11:52:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XML parsing libraries"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"
HOMEPAGE="http://expat.sourceforge.net"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	econf || die

	# parallel make doesnt work
	make || die
}

src_install() {
	einstall || die

	dodoc COPYING Changes MANIFEST README
	dohtml doc/*
}
