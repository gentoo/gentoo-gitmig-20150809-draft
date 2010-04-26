# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quazip/quazip-0.2.3.ebuild,v 1.2 2010/04/26 20:39:21 maekke Exp $

EAPI=2
inherit multilib qt4

DESCRIPTION="A simple C++ wrapper over Gilles Vollant's ZIP/UNZIP package"
HOMEPAGE="http://quazip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-libs/zlib
	x11-libs/qt-gui:4"

S=${WORKDIR}/${P}/${PN}

src_prepare() {
	sed -i \
		-e "s:/usr/local:/usr:" \
		-e "s:/lib:/$(get_libdir):" \
		${PN}.pro || die
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc ../{NEWS,README}
}
