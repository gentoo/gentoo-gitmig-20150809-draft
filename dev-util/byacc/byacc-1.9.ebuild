# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/byacc/byacc-1.9.ebuild,v 1.4 2003/08/20 04:31:49 vapier Exp $

inherit eutils

DESCRIPTION="the best variant of the Yacc parser generator"
HOMEPAGE="http://dickey.his.com/byacc/byacc.html"
SRC_URI="http://sources.isc.org/devel/tools/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc"

src_compile() {
	epatch ${FILESDIR}/mkstemp.patch
	make PROGRAM=byacc CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin byacc
	mv yacc.1 byacc.1
	doman byacc.1
	dodoc ACKNOWLEDGEMENTS MANIFEST NEW_FEATURES NOTES README
}
