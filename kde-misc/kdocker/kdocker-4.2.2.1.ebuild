# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdocker/kdocker-4.2.2.1.ebuild,v 1.1 2009/10/13 17:57:43 ssuominen Exp $

EAPI=2
inherit qt4

DESCRIPTION="KDocker will help you dock any application into the system tray"
HOMEPAGE="https://launchpad.net/kdocker/"
SRC_URI="http://launchpad.net/kdocker/trunk/4.2.2/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	qt4_src_prepare
	sed -i -e 's:/local/:/:g' ${PN}.pro || die
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog CREDITS README TODO
}
