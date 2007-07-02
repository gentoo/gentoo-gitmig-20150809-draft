# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/tuxnes/tuxnes-0.75-r1.ebuild,v 1.1 2007/07/02 16:11:11 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="emulator for the 8-bit Nintendo Entertainment System"
HOMEPAGE="http://tuxnes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X ggi"

RDEPEND="X? (
		x11-libs/libXext
		x11-libs/libICE
		x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libSM )
	ggi? ( >=media-libs/libggi-2.0.1 )"
DEPEND="${RDEPEND}
	X? (
		x11-proto/xextproto
		x11-proto/xproto )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-configure.in.patch \
		"${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/${P}-include.patch \
		"${FILESDIR}"/${P}-exec-stack.patch
	eautoreconf
}

src_compile() {
	egamesconf \
		--without-w \
		$(use_with ggi) \
		$(use_with X x) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon tuxnes.xpm tuxnes2.xpm
	dodoc AUTHORS BUGS ChangeLog CHANGES NEWS README THANKS
	prepgamesdirs
}
