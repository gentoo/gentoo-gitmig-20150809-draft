# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/nxtvepg/nxtvepg-2.5.1.ebuild,v 1.1 2003/05/09 12:53:20 phosphan Exp $

DESCRIPTION="receive and browse free TV programme listings via bttv for tv networks in Europe"
HOMEPAGE="http://nxtvepg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=dev-lang/tcl-8.0
		>=dev-lang/tk-8.0"

DEPEND="${RDEPEND}
		sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}.patch
}

src_compile() {
    make ROOT="${D}" prefix="/usr" || die "make failed"
}

src_install() {
    einstall ROOT="${D}" || die "install failed"
    dodoc README COPYRIGHT CHANGES TODO
	dohtml manual.html
}

