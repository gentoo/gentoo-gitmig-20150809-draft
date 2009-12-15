# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/scythia/scythia-0.9.3_p2.ebuild,v 1.1 2009/12/15 11:14:47 ssuominen Exp $

EAPI=2
inherit qt4

DESCRIPTION="Just a small FTP client"
HOMEPAGE="http://scythia.free.fr/"
SRC_URI="http://scythia.free.fr/wp-content/${PN}_${PV/_p/-}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e 's:/usr/share/applnk/Internet:/usr/share/applications:g' \
		scythia.pro || die
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc AUTHORS
}
