# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-mixer/sdl-mixer-1.2.5-r1.ebuild,v 1.17 2004/11/08 05:53:19 vapier Exp $

inherit eutils gnuconfig

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Simple Direct Media Layer Mixer Library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_mixer/index.html"
SRC_URI="http://www.libsdl.org/projects/SDL_mixer/release/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86"
IUSE="mpeg mikmod oggvorbis"

#	mikmod? ( >=media-libs/libmikmod-3.1.10 )
RDEPEND=">=media-libs/libsdl-1.2.5
	>=media-libs/smpeg-0.4.4-r1
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-gcc3.patch"
	epatch "${FILESDIR}/${P}-amd64-mikmod.patch"
	autoreconf -i || die
	sed -i \
		-e 's:/usr/local/lib/timidity:/usr/share/timidity:' \
		timidity/config.h \
		|| die "sed timidity/config.h failed"
	gnuconfig_update
}

src_compile() {
	econf \
		$(use_enable mikmod mod) \
		$(use_enable mpeg music-mp3) \
		$(use_enable oggvorbis music-ogg) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README
}
