# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/typespeed/typespeed-0.4.4-r1.ebuild,v 1.1 2005/03/21 01:49:54 mr_bones_ Exp $

inherit games

DESCRIPTION="Test your typing speed, and get your fingers CPS"
HOMEPAGE="http://ls.purkki.org/typespeed/"
SRC_URI="http://ls.purkki.org/typespeed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	local f

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/01_all_statedir-fix.patch"
	sed -i \
		-e '/^all:/s/clean//' \
		-e '/^CC =/d' \
		-e "s:^CFLAGS =.*:& ${CFLAGS}:" Makefile \
		|| die "sed failed"
	make clean
	for f in words.*
	do
		touch high.${f}
	done
}

src_install() {
	dogamesbin typespeed || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp words* "${D}${GAMES_DATADIR}/${PN}/" || die "cp failed"
	dodoc README TODO Changes BUGS
	newman typespeed.1 typespeed.6
	insinto "${GAMES_STATEDIR}/${PN}"
	doins high.words.* || die "doins failed"
	prepgamesdirs
	chmod g+w "${D}${GAMES_STATEDIR}"/${PN}/*
}

pkg_postrm() {
	echo
	einfo "${PN} scorefiles was installed into ${GAMES_STATEDIR}/${PN}"
	einfo "and haven't been removed."
	einfo "To get rid of ${PN} completely, you can safely remove"
	einfo "${GAMES_STATEDIR}/${PN} running:"
	echo
	einfo "rm -rf ${GAMES_STATEDIR}/${PN}"
	echo
}
