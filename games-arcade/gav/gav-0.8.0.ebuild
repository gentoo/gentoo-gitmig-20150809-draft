# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gav/gav-0.8.0.ebuild,v 1.7 2004/11/08 02:00:41 josejx Exp $

inherit games

DESCRIPTION="GPL Arcade Volleyball"
HOMEPAGE="http://gav.sourceforge.net"
# the themes are behind a lame php-counter script.
SRC_URI="mirror://sourceforge/gav/${P}.tar.gz
	mirror://gentoo/fabeach.tgz
	mirror://gentoo/florindo.tgz
	mirror://gentoo/inverted.tgz
	mirror://gentoo/naive.tgz
	mirror://gentoo/unnamed.tgz
	mirror://gentoo/yisus.tgz
	mirror://gentoo/yisus2.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 sparc"
IUSE=""

RDEPEND="media-libs/sdl-image
	media-libs/sdl-net
	media-libs/libsdl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"


src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	cp Makefile.Linux Makefile               || die "cp 1 failed"
	cp automa/Makefile.Linux automa/Makefile || die "cp 2 failed"
	cp menu/Makefile.Linux menu/Makefile     || die "cp 3 failed"
	cp net/Makefile.Linux net/Makefile       || die "cp 4 failed"

	sed -i \
		-e "s:/usr/bin:${GAMES_BINDIR}:" Makefile || \
			die "sed Makefile failed"
	sed -i \
		-e "/-Wall/ s$ ${CXXFLAGS}" CommonHeader || \
			die "sed CommonHeader failed"

	# Now, unpack the additional themes
	cd ${S}/themes
	# unpack everything because it's easy
	unpack ${A}
	# and kill off what we don't want
	rm -rf ${P}

	# no reason to have executable files in the themes
	find . -type f -exec chmod a-x \{\} \;
}

src_compile() {
	# bug #41530 - doesn't like the hot parallel make action.
	emake -j1 || die "emake failed"
}

src_install() {
	dodir "${GAMES_BINDIR}"   || die "dodir failed"
	make ROOT="${D}" install || die "make install failed"
	cp -r sounds/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc CHANGELOG README
	prepgamesdirs
}
