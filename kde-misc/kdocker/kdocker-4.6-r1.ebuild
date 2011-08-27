# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdocker/kdocker-4.6-r1.ebuild,v 1.2 2011/08/27 21:58:24 dilfridge Exp $

EAPI=3
inherit base qt4-r2

DESCRIPTION="KDocker will help you dock any application into the system tray"
HOMEPAGE="https://launchpad.net/kdocker/"
SRC_URI="http://launchpad.net/kdocker/trunk/${PV:0:3}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-libs/qt-core
	x11-libs/qt-gui
"
RDEPEND=${DEPEND}

PATCHES=( "${FILESDIR}/${P}-icon.patch" )

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog CREDITS README TODO
}
