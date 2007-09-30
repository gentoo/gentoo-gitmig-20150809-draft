# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qjoypad/qjoypad-3.4.ebuild,v 1.9 2007/09/30 21:43:29 mr_bones_ Exp $

inherit qt3 eutils

DESCRIPTION="translate gamepad/joystick input into key strokes/mouse actions in X"
HOMEPAGE="http://qjoypad.sourceforge.net/"
SRC_URI="mirror://sourceforge/qjoypad/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXtst
	$(qt_min_version 3.3)"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	# makefile has silly dependencies
	sed -i \
		-e "/^CFLAGS/s:-pipe -Wall -W -O2:${CFLAGS}:" \
		-e "/^CXXFLAGS/s:-pipe -Wall -W -O2:${CXXFLAGS}:" \
		-e '/^Makefile:/s|:.*||' \
		Makefile || die "sed make depends failed"
	epatch "${FILESDIR}/${P}"-gcc41.patch
}

src_compile() {
	cd src
	eqmake3 qjoypad.pro PREFIX=/usr
	emake || die "emake failed"
}

src_install() {
	dobin src/qjoypad || die "bin"
	insinto /usr/share/pixmaps/${PN}
	doins icons/* || die "icons"
	dosym gamepad4-24x24.png /usr/share/pixmaps/${PN}/icon24.png
	dosym gamepad4-64x64.png /usr/share/pixmaps/${PN}/icon64.png
	dodoc README.txt
	make_desktop_entry qjoypad QJoypad /usr/share/pixmaps/${PN}/icon64.png
}
