# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-1.0.2.ebuild,v 1.12 2008/12/15 19:05:06 angelos Exp $

DESCRIPTION="the glue between Coin3D and Qt3"
SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org/"

SLOT="0"
LICENSE="|| ( GPL-2 PEL )"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="=x11-libs/qt-3*
	>=media-libs/coin-${PV}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog* NEWS README*
	docinto txt
	dodoc docs/qtcomponents.doxygen
}
