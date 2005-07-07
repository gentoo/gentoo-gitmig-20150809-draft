# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.6.4.ebuild,v 1.9 2005/07/07 05:01:32 caleb Exp $

inherit kde

IUSE="kde"

DEPEND="=x11-libs/qt-3*
	kde? ( >=kde-base/kdelibs-3 )"

SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent QT/KDE Gnutella Client"

SLOT="3" # why??
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
export MAKEOPTS="$MAKEOPTS -j1"

src_compile() {
	kde_src_compile myconf
	use kde || myconf="$myconf --with-kde=no"
	kde_src_compile configure make
}
