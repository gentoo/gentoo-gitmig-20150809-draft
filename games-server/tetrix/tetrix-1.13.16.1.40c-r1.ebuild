# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/tetrix/tetrix-1.13.16.1.40c-r1.ebuild,v 1.2 2004/02/03 20:40:25 mr_bones_ Exp $

inherit eutils gcc games

MY_SV=${PV#*.*.*.}
MY_PV=${PV%.${MY_SV}}
MY_P="tetrinetx-${MY_PV}+qirc-${MY_SV}"

DESCRIPTION="A GNU TetriNET server"
HOMEPAGE="http://tetrinetx.sourceforge.net/"
SRC_URI="mirror://sourceforge/tetrinetx/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="net-libs/adns"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-paths.patch
	sed -i \
		-e "s:GENTOO_CONFDIR:${GAMES_SYSCONFDIR}/${PN}:" \
		-e "s:GENTOO_STATEDIR:${GAMES_STATEDIR}/${PN}:" \
		-e "s:GENTOO_LOGDIR:${GAMES_LOGDIR}:" \
		src/config.h bin/game.conf
}

src_compile() {
	cd src
	$(gcc-getCC) ${CFLAGS} main.c -o tetrix -ladns || die "compile failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README README.qirc.spectators

	dogamesbin src/tetrix
	insinto ${GAMES_SYSCONFDIR}/${PN}
	doins bin/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/tetrix.rc tetrix

	prepgamesdirs
}
