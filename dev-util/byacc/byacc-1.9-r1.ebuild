# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/byacc/byacc-1.9-r1.ebuild,v 1.1 2004/04/05 04:14:03 agriffis Exp $

inherit eutils

DESCRIPTION="the best variant of the Yacc parser generator"
HOMEPAGE="http://dickey.his.com/byacc/byacc.html"
SRC_URI="http://sources.isc.org/devel/tools/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc ia64 ~sparc ~alpha ~mips ~hppa"

src_compile() {
	epatch ${FILESDIR}/mkstemp.patch

	# The following patch fixes yacc to run correctly on ia64 (and
	# other 64-bit arches).  See bug 46233
	epatch ${FILESDIR}/byacc-1.9-ia64.patch

	make PROGRAM=byacc CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin byacc
	mv yacc.1 byacc.1
	doman byacc.1
	dodoc ACKNOWLEDGEMENTS MANIFEST NEW_FEATURES NOTES README
}
