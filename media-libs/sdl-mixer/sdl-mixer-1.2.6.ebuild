# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-mixer/sdl-mixer-1.2.6.ebuild,v 1.7 2005/07/06 22:58:39 vapier Exp $

inherit gnuconfig

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="Simple Direct Media Layer Mixer Library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_mixer/index.html"
SRC_URI="http://www.libsdl.org/projects/SDL_mixer/release/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="mpeg mikmod oggvorbis"

DEPEND=">=media-libs/libsdl-1.2.5
	>=media-libs/smpeg-0.4.4-r1
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	mikmod? ( >=media-libs/libmikmod-3.1.10 )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:/usr/local/lib/timidity:/usr/share/timidity:' \
		timidity/config.h \
		|| die "sed timidity/config.h failed"
	gnuconfig_update
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable mikmod music-libmikmod) \
		$(use_enable mpeg music-mp3) \
		$(use_enable oggvorbis music-ogg) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README
}
