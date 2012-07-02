# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/hashcat-gui/hashcat-gui-0.5.1.ebuild,v 1.1 2012/07/02 02:12:24 zerochaos Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="A gui for the *hashcat* suite of tools"
HOMEPAGE="https://github.com/scandium/hashcat-gui"
#HOMEPAGE="http://hashcat.net/hashcat-gui/"

SRC_URI="https://github.com/scandium/hashcat-gui/zipball/b6b01be723742ad89ba31fdb2c30b35306318f8b -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="app-crypt/hashcat-bin
	app-crypt/oclhashcat-plus-bin
	app-crypt/oclhashcat-lite-bin
	x11-libs/qt-gui
	x11-libs/qt-core"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/scandium-hashcat-gui-b6b01be

src_prepare() {
	sed -i 's#./hashcat#/opt/hashcat-bin#g' src/mainwindow.cpp
	sed -i 's#./oclHashcat-plus#/opt/oclhashcat-plus-bin#g' src/mainwindow.cpp
	sed -i 's#./oclHashcat-lite#/opt/oclhashcat-lite-bin#g' src/mainwindow.cpp
}

src_install() {
	dodoc ChangeLog FAQ INSTALL README TODO

	cd src
	eqmake4 -config release
	emake

	dobin hashcat-gui
}
