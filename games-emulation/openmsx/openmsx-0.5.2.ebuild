# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/openmsx/openmsx-0.5.2.ebuild,v 1.6 2008/03/06 22:00:08 wolf31o2 Exp $

inherit flag-o-matic eutils games

DESCRIPTION="MSX emulator that aims for perfection"
HOMEPAGE="http://openmsx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="dev-lang/tcl
	dev-libs/libxml2
	media-libs/libpng
	sys-libs/zlib
	media-libs/sdl-image
	media-libs/libsdl
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-custom.mk.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	# fix bug 32745
	replace-flags -Os -O2

	egamesconf || die
	emake || die "Fatal error during compilation"
}

src_install() {
	egamesinstall \
		OPENMSX_INSTALL="${D}/usr/games/openmsx" || die

	dogamesbin "${D}"/usr/games/openmsx/bin/openmsx
	dodoc README AUTHORS
	dohtml -r doc/*

	# Tidy up install
	rm -f "${D}${GAMES_DATADIR}/openmsx/"*.{txt,tex,html,png,css}

	prepgamesdirs
}
