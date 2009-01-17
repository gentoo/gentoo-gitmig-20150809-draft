# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngeo/gngeo-0.7.ebuild,v 1.6 2009/01/17 18:21:17 mr_bones_ Exp $

inherit eutils autotools games

DESCRIPTION="A NeoGeo emulator"
HOMEPAGE="http://m.peponas.free.fr/gngeo/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/sdl-image
	media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-execstacks.patch \
		"${FILESDIR}"/${P}-concurrentMake.patch
	eautoreconf
}

src_compile() {
	egamesconf --disable-i386asm || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS FAQ NEWS README* TODO sample_gngeorc
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "A licensed NeoGeo BIOS copy is required to run the emulator."
	echo
}
