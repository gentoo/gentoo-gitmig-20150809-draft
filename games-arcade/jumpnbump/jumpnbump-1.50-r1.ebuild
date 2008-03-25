# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/jumpnbump/jumpnbump-1.50-r1.ebuild,v 1.10 2008/03/25 14:58:18 coldwind Exp $

inherit eutils games

DESCRIPTION="a funny multiplayer game about cute little fluffy bunnies"
HOMEPAGE="http://www.jumpbump.mine.nu/"
SRC_URI="http://www.jumpbump.mine.nu/port/${P}.tar.gz
	mirror://gentoo/${P}-autotool.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X fbcon kde svga tk"

DEPEND="X? ( x11-libs/libXext )
	kde? ( || (
		kde-base/kdialog
		kde-base/kdebase ) )
	media-libs/sdl-mixer
	media-libs/libsdl
	media-libs/sdl-net"
RDEPEND="${DEPEND}
	tk? (
		dev-lang/tcl
		dev-lang/tk )"

src_unpack() {
	unpack ${P}.tar.gz
	epatch "${DISTDIR}/${P}-autotool.patch.bz2"
	cd "${S}"
	chmod +x configure
	sed -i \
		-e "/PREFIX/ s:PREFIX.*:\"${GAMES_DATADIR}/${PN}/jumpbump.dat\":" \
		globals.h \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# clean up a bit.  It leave a dep on Xdialog but ignore that.
	use fbcon || rm -f "${D}${GAMES_BINDIR}/jumpnbump.fbcon"
	use kde || rm -f "${D}${GAMES_BINDIR}/jumpnbump-kdialog"
	use svga || rm -f "${D}${GAMES_BINDIR}/jumpnbump.svgalib"
	use tk || rm -f "${D}${GAMES_BINDIR}/jnbmenu.tcl"
	newicon sdl/jumpnbump64.xpm ${PN}.xpm
	make_desktop_entry jumpnbump "Jump n Bump" ${PN}
	prepgamesdirs
}
