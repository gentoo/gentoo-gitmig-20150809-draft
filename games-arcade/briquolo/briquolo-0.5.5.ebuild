# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/briquolo/briquolo-0.5.5.ebuild,v 1.4 2006/10/05 17:17:24 nyhm Exp $

inherit eutils games

DESCRIPTION="Breakout with 3D representation based on OpenGL"
HOMEPAGE="http://briquolo.free.fr/en/index.html"
SRC_URI="http://briquolo.free.fr/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/libpng
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# no thanks we'll take care of it.
	sed -i \
		-e '/^SUBDIRS/s/desktop//' \
		Makefile.in \
		|| die "sed Makefile.in failed"
	sed -i \
		-e "/CXXFLAGS/s/-O3/${CXXFLAGS}/" \
		configure \
		|| die "sed configure failed"
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
