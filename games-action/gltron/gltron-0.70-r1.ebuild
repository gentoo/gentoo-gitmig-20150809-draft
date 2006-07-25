# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/gltron/gltron-0.70-r1.ebuild,v 1.4 2006/07/25 07:00:23 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="3d tron, just like the movie"
HOMEPAGE="http://gltron.sourceforge.net/"
SRC_URI="mirror://sourceforge/gltron/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	sys-libs/zlib
	media-libs/libpng
	>=media-libs/libsdl-1.2
	media-libs/sdl-mixer
	media-libs/sdl-sound"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch \
		"${FILESDIR}"/${P}-prototypes.patch \
		"${FILESDIR}"/${P}-debian.patch
}

src_compile() {
	# warn/debug/profile just modify CFLAGS, they aren't
	# real options, so don't utilize USE flags here
	egamesconf \
		--disable-warn \
		--disable-debug \
		--disable-profile \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
	dohtml *.html
	doicon ${FILESDIR}/${PN}.png
	make_desktop_entry ${PN} GLtron ${PN}.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	if ! use mikmod ; then
		echo
		ewarn "Since you don't have the mikmod USE flag set, there won't"
		ewarn "be any in-game music for ${PN}."
	fi
}
