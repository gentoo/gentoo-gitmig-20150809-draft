# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtommath/libtommath-0.29.ebuild,v 1.4 2004/06/24 23:24:35 agriffis Exp $

DESCRIPTION="highly optimized and portable routines for integer based number theoretic applications"
HOMEPAGE="http://math.libtomcrypt.org/"
SRC_URI="http://math.libtomcrypt.org/files/ltm-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

src_compile() {
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*
}
