# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/nxtvepg/nxtvepg-2.5.1-r1.ebuild,v 1.1 2003/05/22 08:12:15 phosphan Exp $

DESCRIPTION="receive and browse free TV programme listings via bttv for tv networks in Europe"
HOMEPAGE="http://nxtvepg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

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
    make prefix="/usr" || die "make failed"
}

src_install() {
    einstall resdir="${D}/usr/X11R6/lib/X11" || die "install failed"
    dodoc README COPYRIGHT CHANGES TODO
	dohtml manual.html
}

