# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/widelands/widelands-0.0.9.5-r1.ebuild,v 1.3 2007/02/08 10:02:30 nyhm Exp $

inherit eutils flag-o-matic toolchain-funcs games

DESCRIPTION="A game similar to Settlers 2"
HOMEPAGE="http://www.widelands.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-b${PV:4:1}half-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug nls"

RDEPEND="media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/sdl-ttf
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-b9half

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${PN}-0.0.9-amd64.patch \
		"${FILESDIR}"/${PN}-makefile.patch \
		"${FILESDIR}"/${P}-gcc41.patch
	sed -i -e "s:__ppc__:__PPC__:g" "${S}"/src/machdep.h || die "sed failed"

	if use nls ; then
		cd "${S}"/locale
		cp ../utils/*.py .
	fi
}

src_compile() {
	filter-flags -fomit-frame-pointer

	emake \
		CXX=$(tc-getCXX) \
		IMPLICIT_LIBINTL=1 \
		$(use debug && echo DEBUG=1) \
		|| die "emake failed"

	if use nls ; then
		cd "${S}"/locale
		./buildcat.py
		rm -f *.p* .cvsignore tmp
	fi
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}

	insinto "${dir}"
	doins -r fonts maps pics tribes worlds campaigns $(use nls && echo locale) \
		|| die "doins failed"

	exeinto "${dir}"
	doexe ${PN} || die "doexe failed"
	games_make_wrapper widelands ./widelands "${dir}"

	dodoc AUTHORS ChangeLog README.developers

	newicon pics/wl-ico-48.png ${PN}.png
	make_desktop_entry ${PN} Widelands
	prepgamesdirs
}
