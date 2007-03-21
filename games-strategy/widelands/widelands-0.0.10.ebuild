# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/widelands/widelands-0.0.10.ebuild,v 1.1 2007/03/21 20:56:02 nyhm Exp $

inherit eutils flag-o-matic toolchain-funcs versionator games

MY_PV=$(get_version_component_range 3)
DESCRIPTION="A game similar to Settlers 2"
HOMEPAGE="http://www.widelands.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-build${MY_PV}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/sdl-ttf
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f $(find -name SConscript)

	epatch "${FILESDIR}"/${P}-build.patch

	sed -i 's:__ppc__:__PPC__:' src/s2map.cc \
		|| die "sed s2map.cc failed"
	sed -i "s:/usr/share/games:${GAMES_DATADIR}:" src/wlapplication.cc \
		|| die "sed wlapplication.cc failed"
}

src_compile() {
	filter-flags -fomit-frame-pointer
	emake CXX=$(tc-getCXX) || die "emake failed"

	if use nls ; then
		cd locale
		../utils/buildcat.py || die
	fi
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r campaigns fonts maps music pics sound tribes txts worlds \
		|| die "doins failed"

	insinto "${GAMES_DATADIR}"/${PN}/locale
	local d
	for d in locale/* ; do
		if [[ -d ${d} ]] ; then
			doins -r ${d} || die "doins ${d} failed"
		fi
	done

	newicon pics/wl-ico-48.png ${PN}.png
	make_desktop_entry ${PN} Widelands

	dodoc ChangeLog CREDITS README.developers
	prepgamesdirs
}
