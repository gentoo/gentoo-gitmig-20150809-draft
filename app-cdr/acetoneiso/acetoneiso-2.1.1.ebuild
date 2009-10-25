# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/acetoneiso/acetoneiso-2.1.1.ebuild,v 1.1 2009/10/25 10:32:17 ssuominen Exp $

EAPI=2
MY_P=${PN}_${PV}

inherit qt4

DESCRIPTION="a feature-rich and complete software application to manage CD/DVD images"
HOMEPAGE="http://www.acetoneteam.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-core:4
	x11-libs/qt-webkit:4"

S=${WORKDIR}/${MY_P}/${PN}

src_prepare() {
	sed -i -e 's:unrar-nonfree:unrar:g' sources/compress.h locale/*.ts || die
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc ../{AUTHORS,CHANGELOG,FEATURES,README}
}
