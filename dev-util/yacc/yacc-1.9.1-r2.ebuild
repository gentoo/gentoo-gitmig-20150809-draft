# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/yacc/yacc-1.9.1-r2.ebuild,v 1.1 2004/04/05 04:09:12 agriffis Exp $

inherit eutils

DESCRIPTION="Yacc"
HOMEPAGE="http://dinosaur.compilertools.net/#yacc"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/devel/compiler-tools/${P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ppc64 sparc alpha mips hppa amd64 ia64 s390"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND} >=sys-apps/sed-4"

src_unpack () {
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
