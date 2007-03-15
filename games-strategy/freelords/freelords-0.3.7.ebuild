# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freelords/freelords-0.3.7.ebuild,v 1.8 2007/03/15 12:17:18 nyhm Exp $

inherit eutils games

DESCRIPTION="Free Warlords clone"
HOMEPAGE="http://www.freelords.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="editor nls"

RDEPEND="dev-libs/expat
	media-libs/sdl-mixer
	media-libs/libsdl
	media-libs/sdl-image
	>=media-libs/freetype-2
	>=media-libs/paragui-1.1.8
	!=media-libs/paragui-1.0*
	=dev-libs/libsigc++-1.2*
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer vorbis ; then
		die "Please emerge sdl-mixer with USE=vorbis"
	fi
	games_pkg_setup
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
	epatch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-freelordsrc.patch
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
	emake \
		DESTDIR="${D}" \
		localedir="/usr/share/locale" \
		fldesktopdir="/usr/share/applications" \
		install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog DEPENDENCIES HACKER NEWS README TODO \
		doc/[[:upper:]]*
	prepgamesdirs
}
