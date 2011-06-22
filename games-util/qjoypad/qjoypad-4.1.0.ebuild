# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qjoypad/qjoypad-4.1.0.ebuild,v 1.5 2011/06/22 05:22:15 tupone Exp $

EAPI=2
inherit eutils qt4-r2

DESCRIPTION="translate gamepad/joystick input into key strokes/mouse actions in X"
HOMEPAGE="http://qjoypad.sourceforge.net/"
SRC_URI="mirror://sourceforge/qjoypad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libXtst
	x11-libs/qt-gui"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xextproto
	x11-proto/xproto"

S="${WORKDIR}"/${P}/src

PATCHES=( "${FILESDIR}"/${P}-underlink.patch )

src_configure() {
	eqmake4 qjoypad.pro PREFIX=/usr DEVDIR=/dev/input
}

src_install() {
	dobin qjoypad || die "bin"
	insinto /usr/share/pixmaps/${PN}
	doins ../icons/* || die "icons"
	dosym gamepad4-24x24.png /usr/share/pixmaps/${PN}/icon24.png
	dosym gamepad4-64x64.png /usr/share/pixmaps/${PN}/icon64.png
	dodoc ../README.txt
	make_desktop_entry qjoypad QJoypad /usr/share/pixmaps/${PN}/icon64.png
}
