# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/jumpnbump/jumpnbump-1.50-r1.ebuild,v 1.1 2004/09/22 07:04:27 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="a funny multiplayer game about cute little fluffy bunnies"
HOMEPAGE="http://www.jumpbump.mine.nu/"
SRC_URI="http://www.jumpbump.mine.nu/port/${P}.tar.gz
	mirror://gentoo/${P}-autotool.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="X tcltk svga fbcon kde"

DEPEND="virtual/libc
	X? ( virtual/x11 )
	>=media-libs/sdl-mixer-1.2
	>=media-libs/libsdl-1.2
	>=media-libs/sdl-net-1.2"
RDEPEND="${DEPEND}
	tcltk? (
		dev-lang/tcl
		dev-lang/tk )"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${WORKDIR}"
	epatch "${DISTDIR}/${P}-autotool.patch.bz2"
	chmod +x "${S}/configure"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	# clean up a bit.  It leave a dep on Xdialog but ignore that.
	use fbcon || rm -f "${D}${GAMES_BINDIR}/jumpnbump.fbcon"
	use kde || rm -f "${D}${GAMES_BINDIR}/jumpnbump-kdialog"
	use svga || rm -f "${D}${GAMES_BINDIR}/jumpnbump.svgalib"
	use tcltk || rm -f "${D}${GAMES_BINDIR}/jnbmenu.tcl"
	prepgamesdirs
}
