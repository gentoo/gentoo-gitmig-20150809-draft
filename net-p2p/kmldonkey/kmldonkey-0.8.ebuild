# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.8.ebuild,v 1.1 2003/05/28 14:54:38 caleb Exp $ 

inherit kde-base || die

need-kde 3

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 3"
SRC_URI="http://savannah.nongnu.org/download/kmldonkey/unstable.pkg/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.gibreel.net/projects/kmldonkey"

pkg_postinst() {
        echo
        echo
        einfo "To configure Kmldonkey use your KDE ControlCenter"
        einfo "To load the Kmldonkey GUI interface, just add the"
        einfo "MLDonkeyApplet miniprog to your taskbar"
        echo
        echo
}

