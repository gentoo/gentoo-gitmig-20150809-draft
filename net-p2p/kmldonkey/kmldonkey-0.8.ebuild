# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.8.ebuild,v 1.11 2004/08/14 14:50:31 swegener Exp $

inherit kde

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 3"
HOMEPAGE="http://www.gibreel.net/projects/kmldonkey"
SRC_URI="http://savannah.nongnu.org/download/kmldonkey/unstable.pkg/${PV}/${P}.tar.gz"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

need-kde 3

pkg_postinst() {
	echo
	echo
	einfo "To configure Kmldonkey use your KDE ControlCenter"
	einfo "To load the Kmldonkey GUI interface, just add the"
	einfo "MLDonkeyApplet miniprog to your taskbar"
	echo
	echo
}
