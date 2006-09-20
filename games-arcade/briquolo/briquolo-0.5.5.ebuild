# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/briquolo/briquolo-0.5.5.ebuild,v 1.2 2006/09/20 16:45:38 blubb Exp $

inherit eutils games

DESCRIPTION="Breakout with 3D representation based on OpenGL"
HOMEPAGE="http://briquolo.free.fr/en/index.html"
SRC_URI="http://briquolo.free.fr/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/libpng
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# no thanks we'll take care of it.
	sed -i \
		-e '/^SUBDIRS/s/desktop//' \
		Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	doicon desktop/briquolo.svg
	make_desktop_entry briquolo Briquolo briquolo.svg
	prepgamesdirs
}
