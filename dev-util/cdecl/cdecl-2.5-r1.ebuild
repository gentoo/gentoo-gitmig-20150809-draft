# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cdecl/cdecl-2.5-r1.ebuild,v 1.5 2004/06/28 04:57:08 ciaranm Exp $

inherit eutils

DESCRIPTION="Turn English phrases to C or C++ declarations"
SRC_URI="ftp://ftp.netsw.org/softeng/lang/c/tools/cdecl/${P}.tar.gz"

KEYWORDS="x86 ~sparc ~mips"
LICENSE="public-domain"
SLOT="0"

DEPEND=">=sys-apps/sed-4
		dev-util/yacc
		readline? ( sys-libs/ncurses
		sys-libs/readline )"

IUSE="readline"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}


src_compile() {
	if use readline; then
		CFLAGS="${CFLAGS} -DUSE_READLINE"
		LIBS="${LIBS} -lreadline -lncurses"
	fi
	emake CFLAGS="${CFLAGS}" LIBS="${LIBS}" || die
}

src_install() {
	dobin cdecl
	dohard /usr/bin/cdecl /usr/bin/c++decl
	dodoc README
	doman *.1
}
