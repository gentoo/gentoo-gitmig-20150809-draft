# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtommath/libtommath-0.30.ebuild,v 1.3 2004/08/28 13:09:34 kugelfang Exp $

DESCRIPTION="highly optimized and portable routines for integer based number theoretic applications"
HOMEPAGE="http://math.libtomcrypt.org/"
SRC_URI="http://math.libtomcrypt.org/files/ltm-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

src_compile() {
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*
}
