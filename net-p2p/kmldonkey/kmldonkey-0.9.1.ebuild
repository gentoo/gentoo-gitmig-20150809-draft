# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.9.1.ebuild,v 1.10 2004/06/25 00:33:47 agriffis Exp $

IUSE=""

inherit kde

need-kde 3

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"
SLOT="0"

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 3"
SRC_URI="http://savannah.nongnu.org/download/kmldonkey/unstable.pkg/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.gibreel.net/projects/kmldonkey"

RDEPEND="${DEPEND}
	>=sys-apps/sed-4.0.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:};:}:g' kcmdonkey/kcmdonkey.cpp || die
}

pkg_postinst() {
	echo
	echo
	einfo "To configure Kmldonkey use your KDE ControlCenter"
	einfo "To load the Kmldonkey GUI interface, just add the"
	einfo "MLDonkeyApplet miniprog to your taskbar"
	echo
	echo
}
