# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wesnoth/wesnoth-1.6.1.ebuild,v 1.3 2009/04/16 06:23:39 mr_bones_ Exp $

EAPI=2
inherit cmake-utils eutils toolchain-funcs flag-o-matic games

DESCRIPTION="Battle for Wesnoth - A fantasy turn-based strategy game"
HOMEPAGE="http://www.wesnoth.org/"
SRC_URI="mirror://sourceforge/wesnoth/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dedicated nls server tinygui"

RDEPEND=">=media-libs/libsdl-1.2.7[X]
	media-libs/sdl-net
	>=media-libs/sdl-ttf-2.0.8
	>=media-libs/sdl-mixer-1.2[vorbis]
	>=media-libs/sdl-image-1.2[jpeg,png]
	dev-libs/boost
	sys-libs/zlib
	x11-libs/pango
	media-libs/fontconfig
	virtual/libintl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!dedicated? (
		tinygui? ( media-gfx/imagemagick[jpeg,png] )
	)
	nls? ( sys-devel/gettext )"

src_prepare() {
	if use dedicated || use server ; then
		sed \
			-e "s:GAMES_BINDIR:${GAMES_BINDIR}:" \
			-e "s:GAMES_STATEDIR:${GAMES_STATEDIR}:" \
			-e "s/GAMES_USER_DED/${GAMES_USER_DED}/" \
			-e "s/GAMES_GROUP/${GAMES_GROUP}/" "${FILESDIR}"/wesnothd.rc \
			> "${T}"/wesnothd \
			|| die "sed failed"
	fi

	# FIXME: remove this bit in the next version
	cp "${FILESDIR}"/config.h.cmake . || die "cp failed"
	sed -i \
		-e '/Version/s/1.6/1.0/' \
		-e '/Icon/s/\.png//' \
		icons/*desktop \
		|| die "sed failed"
}

src_configure() {
	filter-flags -ftracer -fomit-frame-pointer
	if [[ $(gcc-major-version) -eq 3 ]] ; then
		filter-flags -fstack-protector
		append-flags -fno-stack-protector
	fi
	if use dedicated || use server ; then
		mycmakeargs="${mycmakeargs}
			-DENABLE_CAMPAIGN_SERVER=TRUE
			-DENABLE_SERVER=TRUE
			-DSERVER_UID=${GAMES_USER_DED}
			-DSERVER_GID=${GAMES_GROUP}
			-DFIFO_DIR=${GAMES_STATEDIR}/run/wesnothd"
	else
		mycmakeargs="${mycmakeargs}
			-DENABLE_CAMPAIGN_SERVER=FALSE
			-DENABLE_SERVER=FALSE"
	fi
	mycmakeargs="
		${mycmakeargs}
		$(cmake-utils_use_enable !dedicated GAME)
		$(cmake-utils_use_enable !dedicated ENABLE_DESKTOP_ENTRY)
		$(cmake-utils_use_enable nls NLS)
		-DGUI=$(use tinygui && echo tiny || echo normal)
		-DENABLE_FRIBIDI=FALSE
		-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}
		-DPREFERENCES_DIR=.wesnoth
		-DDATAROOTDIR=${GAMES_DATADIR}
		-DBINDIR=${GAMES_BINDIR}
		-DICONDIR=/usr/share/pixmaps
		-DDESKTOPDIR=/usr/share/applications
		-DMANDIR=/usr/share/man
		-DDOCDIR=/usr/share/doc/${PF}"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="README changelog players_changelog" cmake-utils_src_install
	if use dedicated || use server; then
		keepdir "${GAMES_STATEDIR}/run/wesnothd"
		doinitd "${T}"/wesnothd || die "doinitd failed"
	fi

	# FIXME: remove this bit in the next version
	rm -rf "${D}"/usr/share/applications/*desktop
	domenu icons/*desktop

	prepgamesdirs
}
