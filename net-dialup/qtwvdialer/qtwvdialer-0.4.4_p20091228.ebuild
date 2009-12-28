# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.4.4_p20091228.ebuild,v 1.1 2009/12/28 11:50:57 ssuominen Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="Qt4 frontend for wvdial"
HOMEPAGE="http://github.com/schuay/qt4wvdialer/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4[qt3support]"
RDEPEND="${DEPEND}
	net-dialup/wvdial"

src_configure() {
	eqmake4 QtWvDialer.pro
	cd src
	eqmake4 src.pro
}

src_install() {
	dobin bin/qtwvdialer || die
	doicon src/qtwvdialer.png
	make_desktop_entry ${PN} ${PN}
	dodoc AUTHORS CHANGELOG README
}
