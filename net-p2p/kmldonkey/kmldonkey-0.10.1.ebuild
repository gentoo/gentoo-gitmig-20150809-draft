# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.10.1.ebuild,v 1.1 2005/07/27 21:53:42 greg_g Exp $

inherit kde eutils

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 3"
HOMEPAGE="http://www.kmldonkey.org/"
SRC_URI="http://savannah.nongnu.org/download/kmldonkey/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kcontrol kde-base/kdebase )"

need-kde 3

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-sandbox.patch
	WANT_AUTOMAKE=1.7 make -f Makefile.cvs
}

pkg_postinst() {
	echo
	einfo "To configure Kmldonkey, you can use the KDE Control Center."
	echo
}
