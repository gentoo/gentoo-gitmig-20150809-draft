# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freelords/freelords-0.3.7.ebuild,v 1.3 2006/04/17 13:27:31 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Free Warlords clone"
HOMEPAGE="http://www.freelords.org/"
SRC_URI="mirror://sourceforge/freelords/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="editor nls"

RDEPEND="dev-libs/expat
	media-libs/sdl-mixer
	>=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2
	>=media-libs/freetype-2
	>=media-libs/paragui-1.1.8
	!=media-libs/paragui-1.0*
	=dev-libs/libsigc++-1.2*"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

pkg_setup() {
	games_pkg_setup
	if ! built_with_use -o media-libs/sdl-mixer vorbis oggvorbis ; then
		die "Please emerge sdlmixer with USE=vorbis"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:\"freelordsrc\":\"${GAMES_SYSCONFDIR}/freelordsrc\":" \
		src/main.cpp \
		|| die "sed src/main.cpp failed"
	sed -i \
		-e '/^localedir/ s:$(datadir):/usr/share:' \
		-e 's:$(prefix)/share/locale:/usr/share/locale:' src/Makefile.in \
		|| die "sed src/Makefile.in failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-paraguitest \
		$(use_enable editor) \
		$(use_enable nls) \
		|| die
	emake \
		localedir="/usr/share/locale" \
		CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		localedir="/usr/share/locale" \
		fldesktopdir="/usr/share/applications" \
		install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog DEPENDENCIES HACKER NEWS README TODO \
		doc/[[:upper:]]*
	prepgamesdirs
}
