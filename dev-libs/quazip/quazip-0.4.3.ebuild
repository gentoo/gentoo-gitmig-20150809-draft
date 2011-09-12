# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quazip/quazip-0.4.3.ebuild,v 1.1 2011/09/12 22:23:16 dilfridge Exp $

EAPI=4

inherit multilib qt4-r2

DESCRIPTION="A simple C++ wrapper over Gilles Vollant's ZIP/UNZIP package"
HOMEPAGE="http://quazip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="sys-libs/zlib
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${P}/${PN}

DOCS="../NEWS ../README.txt"

src_prepare() {
	sed -i \
		-e "s:/usr/local:${EPREFIX}/usr:" \
		-e "s:/lib:/$(get_libdir):" \
		${PN}.pro || die
	qt4-r2_src_prepare
}
