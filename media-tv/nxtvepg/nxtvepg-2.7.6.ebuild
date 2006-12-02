# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nxtvepg/nxtvepg-2.7.6.ebuild,v 1.3 2006/12/02 09:50:28 dev-zero Exp $

inherit eutils toolchain-funcs

DESCRIPTION="receive and browse free TV programme listings via bttv for tv networks in Europe"
HOMEPAGE="http://nxtvepg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/tcl-8.0
	>=dev-lang/tk-8.0
	x11-libs/libX11
	x11-libs/libXmu"

DEPEND="${RDEPEND}
	sys-apps/sed
	sys-kernel/linux-headers
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/nxtvepg-db.patch"
}

src_compile() {
	emake -j1 CC=$(tc-getCC) prefix="/usr" || die "emake failed"
}

src_install() {
	emake ROOT="${D}" prefix="/usr" install || die "emake install failed"
	dodoc README CHANGES TODO
	dohtml manual*.html
}
