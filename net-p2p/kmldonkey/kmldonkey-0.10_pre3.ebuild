# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.10_pre3.ebuild,v 1.2 2004/06/25 00:33:47 agriffis Exp $

inherit kde-base
need-kde 3

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 3"
SRC_URI="http://savannah.nongnu.org/download/kmldonkey/${MY_P}.tar.bz2"
HOMEPAGE="http://www.kmldonkey.org/"
IUSE=""

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
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
