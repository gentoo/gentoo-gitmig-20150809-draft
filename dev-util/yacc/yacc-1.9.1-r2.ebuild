# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/yacc/yacc-1.9.1-r2.ebuild,v 1.4 2004/07/02 05:14:34 eradicator Exp $

inherit eutils

DESCRIPTION="Yacc"
HOMEPAGE="http://dinosaur.compilertools.net/#yacc"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/devel/compiler-tools/${P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Use our CFLAGS
	sed -i -e 's: -O : $(CFLAGS) :' Makefile || die 'sed failed'

	# mkstemp patch from byacc ebuild
	epatch ${FILESDIR}/mkstemp.patch

	# The following patch fixes yacc to run correctly on ia64 (and
	# other 64-bit arches).  See bug 46233
	epatch ${FILESDIR}/yacc-1.9.1-ia64.patch
}

src_compile() {
	make clean || die
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin yacc || die
	doman yacc.1
	dodoc 00README* ACKNOWLEDGEMENTS NEW_FEATURES NO_WARRANTY NOTES README*
}
