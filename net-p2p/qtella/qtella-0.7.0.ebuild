# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.7.0.ebuild,v 1.5 2004/07/19 23:33:26 squinky86 Exp $

inherit kde eutils

IUSE="kde"
use kde && need-kde 3 || need-qt 3

SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent QT/KDE Gnutella Client"

SLOT="3" # why??
LICENSE="GPL-2"
#masking by keywords as there are known bugs and I don't want to put up with the reports yet
KEYWORDS="~x86 ~ppc"
export MAKEOPTS="$MAKEOPTS -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	if ! use kde; then
		epatch ${FILESDIR}/${PV}-nokde.patch
	fi
}

src_compile() {
	kde_src_compile myconf
	use kde || myconf="$myconf --with-kde=no"
	kde_src_compile configure make
}
