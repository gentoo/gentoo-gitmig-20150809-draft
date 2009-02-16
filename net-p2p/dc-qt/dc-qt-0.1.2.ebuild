# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dc-qt/dc-qt-0.1.2.ebuild,v 1.10 2009/02/16 21:17:57 loki_val Exp $

EAPI=1

inherit eutils qt3 autotools

IUSE="xine"

DESCRIPTION="Direct Connect Text Client, QT Gui"
HOMEPAGE="http://dc-qt.sourceforge.net/"
SRC_URI="mirror://sourceforge/dc-qt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"

DEPEND="x11-libs/qt:3
	>=net-p2p/dctc-0.85.9
	xine? ( >=media-libs/xine-lib-1_rc5 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-xine.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_with xine) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
