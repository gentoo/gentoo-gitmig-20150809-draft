# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qjoypad/qjoypad-4.1.0.ebuild,v 1.8 2012/09/05 10:03:01 jlec Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="Translate gamepad/joystick input into key strokes/mouse actions in X"
HOMEPAGE="http://qjoypad.sourceforge.net/"
SRC_URI="mirror://sourceforge/qjoypad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="
	x11-libs/libXtst
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xextproto
	x11-proto/xproto"

S=${WORKDIR}/${P}/src

PATCHES=( "${FILESDIR}"/${P}-underlink.patch )

src_configure() {
	eqmake4 qjoypad.pro PREFIX=/usr DEVDIR=/dev/input
}

src_install() {
	local i
	dobin qjoypad
	dodoc ../README.txt
	cd ../icons
	for i in *; do
		newicon ${i} ${i/gamepad/qjoypad}
	done
	make_desktop_entry qjoypad QJoypad ${PN}4-64x64
}
