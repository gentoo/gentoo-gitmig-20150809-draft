# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-unix/ucspi-unix-0.36-r1.ebuild,v 1.7 2004/11/05 01:34:06 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A ucspi implementation for unix sockets"
HOMEPAGE="http://untroubled.org/ucspi-unix/"
SRC_URI="http://untroubled.org/ucspi-unix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/bglibs-1.009-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo-head.patch
}

src_compile() {
	echo "$(tc-getCC) ${CFLAGS} -I${ROOT}/usr/lib/bglibs/include" > conf-cc
	echo "$(tc-getCC) -s -L${ROOT}/usr/lib/bglibs/lib" > conf-ld
	make || die  #don't use emake b/c of jobserver
}

src_install() {
	dobin unixserver unixclient unixcat || die
	doman unixserver.1 unixclient.1
	dodoc ANNOUNCEMENT ChangeLog NEWS PROTOCOL README TODO
}
