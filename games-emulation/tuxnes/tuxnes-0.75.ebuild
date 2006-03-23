# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/tuxnes/tuxnes-0.75.ebuild,v 1.8 2006/03/23 20:42:41 mr_bones_ Exp $

inherit flag-o-matic eutils games

DESCRIPTION="emulator for the 8-bit Nintendo Entertainment System"
HOMEPAGE="http://tuxnes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X ggi"

RDEPEND="sys-libs/zlib
	X? ( || (
			(
				x11-libs/libXext
				x11-libs/libICE
				x11-libs/libX11
				x11-libs/libXpm
				x11-libs/libSM )
			virtual/x11 ) )
	ggi? ( >=media-libs/libggi-2.0.1 )"
DEPEND="${RDEPEND}
	X? ( || (
			(
				x11-proto/xextproto
				x11-proto/xproto )
			virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-configure.in.patch \
		"${FILESDIR}"/${P}-gcc34.patch
	export WANT_AUTOCONF=2.5
	aclocal && automake && autoconf || die "autoconf failed"
}

src_compile() {
	replace-flags "-O?" "-O"
	egamesconf \
		--without-w \
		$(use_with ggi) \
		$(use_with X x) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doicon tuxnes.xpm tuxnes2.xpm
	dodoc AUTHORS BUGS ChangeLog CHANGES NEWS README THANKS
	prepgamesdirs
}
