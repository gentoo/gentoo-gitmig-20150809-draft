# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.10_pre4.ebuild,v 1.2 2004/09/14 22:38:18 carlo Exp $

inherit kde eutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 3"
HOMEPAGE="http://www.kmldonkey.org/"
SRC_URI="http://savannah.nongnu.org/download/kmldonkey/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="arts"

need-kde 3

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/kmldonkey-0.10_pre4-sandbox.patch
	make -f admin/Makefile.common
}

src_compile() {
	./configure --prefix=$KDEDIR $(use_with arts)
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
