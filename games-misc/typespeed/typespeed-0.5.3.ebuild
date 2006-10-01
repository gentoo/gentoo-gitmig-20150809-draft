# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/typespeed/typespeed-0.5.3.ebuild,v 1.1 2006/10/01 23:58:57 nyhm Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Test your typing speed, and get your fingers CPS"
HOMEPAGE="http://tobias.eyedacor.org/typespeed/"
SRC_URI="http://tobias.eyedacor.org/typespeed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^CC/s/gcc/$(tc-getCC)/" \
		-e "/^CFLAGS/s/-W .*$/${CFLAGS}/" \
		-e '/^LDFLAGS/s/=/+=/' \
		-e "s:\$(sysconfdir):${GAMES_SYSCONFDIR}:" \
		-e "s:\$(highfiles):${GAMES_STATEDIR}/${PN}:" \
		-e "s:\$(wordfiles):${GAMES_DATADIR}/${PN}:" \
		Makefile || die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins words.* || die "doins words failed"

	insinto "${GAMES_SYSCONFDIR}"
	doins typespeedrc || die "doins typespeedrc failed"

	insinto "${GAMES_STATEDIR}"/${PN}
	doins high.words.* || die "doins high.words failed"

	dodoc BUGS Changes README TODO
	doman typespeed.6

	chmod 660 "${D}/${GAMES_STATEDIR}"/${PN}/*
	prepgamesdirs
}
