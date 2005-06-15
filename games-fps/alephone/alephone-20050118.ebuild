# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone/alephone-20050118.ebuild,v 1.2 2005/06/15 18:38:53 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="An enhanced version of the game engine from the classic Mac game, Marathon"
HOMEPAGE="http://source.bungie.org/"
SRC_URI="mirror://sourceforge/marathon/aleph-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl lua"

DEPEND="opengl? ( virtual/opengl )
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-net
	lua? ( dev-lang/lua )"

S=${WORKDIR}/aleph-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	NO_CONFIGURE=bah ./autogen.sh || die "autogen failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable opengl) || die
	if ! use lua ; then
		# stupid configure script doesnt have an option
		sed -i \
			-e '/HAVE_LUA/d' config.h \
			|| die "sed HAVE_LUA"
		sed -i \
			-e '/^LIBS/s:-llua -llualib::' $(find -name Makefile) \
			|| die "sed -llua"
	fi
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	keepdir "${GAMES_DATADIR}/AlephOne/"{Images,Map,Shapes,Sounds}
	dodoc AUTHORS README docs/Cheat_Codes
	dohtml docs/MML.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Read the docs and install the data files accordingly to play."
	echo
}
