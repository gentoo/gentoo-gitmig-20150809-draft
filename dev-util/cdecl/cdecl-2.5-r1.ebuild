# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cdecl/cdecl-2.5-r1.ebuild,v 1.10 2006/04/29 01:38:52 weeve Exp $

inherit eutils

DESCRIPTION="Turn English phrases to C or C++ declarations"
SRC_URI="ftp://ftp.netsw.org/softeng/lang/c/tools/cdecl/${P}.tar.gz"
HOMEPAGE="http://www.boutell.com/lsm/lsmbyid.cgi/002083"

KEYWORDS="~amd64 ~mips ~ppc sparc x86"
LICENSE="public-domain"
SLOT="0"

DEPEND=">=sys-apps/sed-4
		dev-util/yacc
		readline? ( sys-libs/ncurses
		sys-libs/readline )
		!<dev-util/cutils-1.6-r2"

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
