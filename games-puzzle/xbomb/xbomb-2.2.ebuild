# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xbomb/xbomb-2.2.ebuild,v 1.4 2008/05/09 14:04:40 armin76 Exp $

inherit eutils games

DESCRIPTION="Minesweeper clone with hexagonal, rectangular and triangular grid"
HOMEPAGE="http://www.gedanken.demon.co.uk/xbomb/"
SRC_URI="http://www.gedanken.demon.co.uk/download-xbomb/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ~ppc64 x86"
IUSE=""

DEPEND="x11-libs/libXaw"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-DESTDIR.patch
	sed -i \
		-e '/strip/d' \
		-e "/^CFLAGS/ { s:=.*:=${CFLAGS}: }" \
		-e "s:/usr/bin:${GAMES_BINDIR}:" \
		"${S}"/Makefile \
		|| die "sed Makefile failed"
	sed -i \
		-e "s:/var/tmp:${GAMES_STATEDIR}/${PN}:g" \
		"${S}"/hiscore.c \
		|| die "sed hiscore.c failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README LSM
	dodir "${GAMES_STATEDIR}"/${PN}
	touch "${D}/${GAMES_STATEDIR}"/${PN}/${PN}{3,4,6}.hi || die "touch failed"
	fperms 660 "${GAMES_STATEDIR}"/${PN}/${PN}{3,4,6}.hi || die "fperms failed"
	prepgamesdirs
}
