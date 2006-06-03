# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone/alephone-20060506-r1.ebuild,v 1.1 2006/06/03 21:39:59 tupone Exp $

inherit eutils games

DESCRIPTION="An enhanced version of the game engine from the classic Mac game, Marathon"
HOMEPAGE="http://source.bungie.org/"
SRC_URI="mirror://sourceforge/marathon/AlephOne-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua opengl speex"

DEPEND="lua? ( dev-lang/lua )
	opengl? ( virtual/opengl )
	speex? ( media-libs/speex )
	dev-libs/boost
	>=media-libs/libsdl-1.2
	media-libs/sdl-image
	media-libs/sdl-net"

S=${WORKDIR}/AlephOne-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp ${FILESDIR}/alephone.png ./
	cp ${FILESDIR}/alephone.sh ./
	sed -i -e "s:GAMES_DATADIR:${GAMES_DATADIR}:g" \
		alephone.sh || die
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable opengl) || die
	if ! use lua ; then
		# stupid configure script doesnt have an option
		dosed -i \
			-e '/HAVE_LUA/d' config.h \
			|| die "sed HAVE_LUA"
		dosed -i \
			-e '/^LIBS/s:-llua -llualib::' $(find -name Makefile) \
			|| die "sed -llua"
	fi
	if ! use speex ; then
		# stupid configure script doesnt have an option
		dosed -i \
			-e '/SPEEX/d:' config.h \
			|| die "sed SPEEX"
		dosed -i \
			-e '/^LIBS/s:-lspeex::' $(find -name Makefile) \
			|| die "sed -lspeex"
	fi
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dogamesbin alephone.sh || die "failed to install wrapper"
	dodoc AUTHORS README docs/Cheat_Codes
	dohtml docs/MML.html
	doicon alephone.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Read the docs and install the data files accordingly to play."
	echo
	einfo "If you only want to install one scenario, read"
	einfo "http://traxus.jjaro.net/traxus/AlephOne:Install_Guide#Single_scenario_3"
	einfo "If you want to install multiple scenarios, read"
	einfo "http://traxus.jjaro.net/traxus/AlephOne:Install_Guide#Multiple_scenarios_3"
	echo
}
