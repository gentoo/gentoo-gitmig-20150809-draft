# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nxtvepg/nxtvepg-2.7.4.ebuild,v 1.1 2005/03/29 23:29:26 pylon Exp $

inherit eutils

DESCRIPTION="receive and browse free TV programme listings via bttv for tv networks in Europe"
HOMEPAGE="http://nxtvepg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND=">=dev-lang/tcl-8.0
	>=dev-lang/tk-8.0"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/nxtvepg-db.patch
}

src_compile() {
	make prefix="/usr" || die "make failed"
}

src_install() {
	make install ROOT=${D} prefix="/usr" || die "install failed"
	dodoc README COPYRIGHT CHANGES TODO
	dohtml manual.html
}
