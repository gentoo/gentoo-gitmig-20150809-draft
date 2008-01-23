# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/attal/attal-0.10.1.ebuild,v 1.4 2008/01/23 18:26:18 mr_bones_ Exp $

inherit eutils toolchain-funcs qt4 games

MY_P="${PN}-src-${PV}"
DESCRIPTION="turn-based strategy game project"
HOMEPAGE="http://www.attal-thegame.org/"
SRC_URI="mirror://sourceforge/attal/${MY_P}.tar.bz2
	mirror://sourceforge/attal/themes-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(qt4_min_version 4)
	media-libs/sdl-mixer"

S=${WORKDIR}/${MY_P}

QT4_BUILT_WITH_USE_CHECK="qt3support"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ../themes .
	find . -name .cvsignore -print0 | xargs -0 rm -f
	epatch "${FILESDIR}"/${P}-{gcc41,gentoo}.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		libCommon/displayHelp.cpp \
		libCommon/attalCommon.cpp \
		server/duel.cpp \
		|| die "sed failed"

	sed -i \
		-e "1i QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}" \
		-e "1i QMAKE_LFLAGS_RELEASE=${LDFLAGS}" \
		$(find . -type f -name '*.pro') \
		|| die "sed failed"
	qmake -o Makefile Makefile.pro || die "qmake failed"
}

src_compile() {
	emake -j1 \
		CXX=$(tc-getCXX) \
		LINK=$(tc-getCXX) \
		|| die "emake failed"
}

src_install() {
	dogamesbin attal-* || die "dogamesbin failed"
	dogameslib.so lib*.so* || die "dogameslib.so failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins HOWTOPLAY.html
	doins -r themes || die "doins themes failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
