# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/tuxnes/tuxnes-0.75.ebuild,v 1.2 2004/02/03 00:54:44 mr_bones_ Exp $

inherit flag-o-matic eutils

DESCRIPTION="emulator for the 8-bit Nintendo Entertainment System"
HOMEPAGE="http://tuxnes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X ggi"

DEPEND=">=media-libs/netpbm-9.12
	X? ( virtual/x11 )
	ggi? ( >=media-libs/libggi-2.0.1 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/configure.in-${P}-gentoo.diff
	autoreconf &>/dev/null
}

src_compile() {
	replace-flags "-O?" "-O"

	# Don't even bother checking for W windows
	econf \
		--without-w \
		`use_with ggi` \
		`use_with X x` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# Install pixmaps
	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins tuxnes.xpm tuxnes2.xpm

	# Install documentation
	dodoc AUTHORS BUGS ChangeLog CHANGES INSTALL NEWS README THANKS
}
