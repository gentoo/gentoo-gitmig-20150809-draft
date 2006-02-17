# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-1.0.2.ebuild,v 1.11 2006/02/17 13:43:05 gustavoz Exp $

DESCRIPTION="A Qt Interface for coin"
SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org/"

SLOT="0"
LICENSE="|| ( GPL-2 PEL )"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="=x11-libs/qt-3*
	>=media-libs/coin-${PV}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* LICENSE* NEWS README*
	docinto txt
	dodoc docs/qtcomponents.doxygen
}
