# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.10.ebuild,v 1.4 2005/07/15 00:02:27 agriffis Exp $

inherit kde eutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 3"
HOMEPAGE="http://www.kmldonkey.org/"
SRC_URI="http://savannah.nongnu.org/download/kmldonkey/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="|| ( kde-base/kcontrol kde-base/kdebase )"
RDEPEND="${DEPEND}"

need-kde 3

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${P}-sandbox.patch
	make -f admin/Makefile.common
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
