# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtommath/libtommath-0.21.ebuild,v 1.1 2003/07/02 14:46:40 vapier Exp $

inherit eutils

DESCRIPTION="highly optimized and portable routines for integer based number theoretic applications"
HOMEPAGE="http://math.libtomcrypt.org/"
SRC_URI="http://math.libtomcrypt.org/files/ltm-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${PV}-doc-fix.patch
}

src_compile() {
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*
}
