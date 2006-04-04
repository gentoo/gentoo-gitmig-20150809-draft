# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gav/gav-0.8.0.ebuild,v 1.11 2006/04/04 19:40:46 tupone Exp $

inherit eutils games

DESCRIPTION="GPL Arcade Volleyball"
HOMEPAGE="http://gav.sourceforge.net/"
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
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="media-libs/sdl-image
	media-libs/sdl-net
	media-libs/libsdl"


src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"

	epatch "${FILESDIR}/${P}"-gcc4.patch
	for d in . automa menu net ; do
		cp ${d}/Makefile.Linux ${d}/Makefile || die "cp ${d}/Makefile"
	done

	sed -i \
		-e "s:/usr/bin:${GAMES_BINDIR}:" Makefile \
		|| die "sed failed"
	sed -i \
		-e "/^CXXFLAGS=/s: -g : ${CXXFLAGS} :" CommonHeader \
		|| die "sed failed"

	# Now, unpack the additional themes
	cd "${S}"/themes
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
	dodir "${GAMES_BINDIR}"
	make ROOT="${D}" install || die "make install failed"
	cp -r sounds/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc CHANGELOG README
	prepgamesdirs
}
