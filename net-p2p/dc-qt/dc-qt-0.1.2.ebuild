# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dc-qt/dc-qt-0.1.2.ebuild,v 1.5 2005/07/25 17:40:28 caleb Exp $

inherit eutils qt3

IUSE="xine"

DESCRIPTION="Direct Connect Text Client, QT Gui"
HOMEPAGE="http://dc-qt.sourceforge.net/"
SRC_URI="mirror://sourceforge/dc-qt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND="$(qt_min_version 3.2)
	>=net-p2p/dctc-0.85.9
	xine? ( >=media-libs/xine-lib-1_rc5 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-xine.patch
	autoreconf
}

src_compile() {
	econf \
	    `use_with xine` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
