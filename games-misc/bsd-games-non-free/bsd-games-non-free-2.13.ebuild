# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/bsd-games-non-free/bsd-games-non-free-2.13.ebuild,v 1.8 2005/04/05 15:56:16 blubb Exp $

inherit games

DESCRIPTION="collection of games from NetBSD"
HOMEPAGE="http://www.advogato.org/proj/bsd-games/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/games/${P}.tar.gz"

# See /usr/share/doc/${P}/COPYRIGHT.hack and CHANGES.rogue
LICENSE="|| ( BSD free-noncomm )"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-apps/miscfiles
	sys-apps/less
	sys-devel/bison
	sys-devel/flex"

# Set GAMES_TO_BUILD variable to whatever you want
export GAMES_TO_BUILD=${GAMES_TO_BUILD:="hack rogue"}

src_unpack() {
	unpack ${A} ; cd ${S}

	cp ${FILESDIR}/config.params-gentoo config.params
	echo bsd_games_cfg_build_dirs=\"${GAMES_TO_BUILD}\" >> ./config.params
}

src_compile() {
	./configure || die
	make OPTIMIZE="${CFLAGS}" || die
}

build_game() { has ${1} ${GAMES_TO_BUILD}; }
do_statefile() {
	touch ${D}/${GAMES_STATEDIR}/${1}
	chmod ug+rw ${D}/${GAMES_STATEDIR}/${1}
}
src_install() {
	dodir ${GAMES_BINDIR} ${GAMES_STATEDIR} /usr/share/man/man{1,6}
	make DESTDIR=${D} install-strip || die

	dodoc AUTHORS BUGS COPYING ChangeLog ChangeLog.0 INSTALL NEWS \
		  PACKAGING README README.non-free SECURITY THANKS TODO YEAR2000 \
		  bsd-games-non-free.lsm

	# set some binaries to run as games group (+S)
	[ `build_game rogue` ] && fperms g+s ${GAMES_BINDIR}/rogue

	# state files
	[ `build_game hack` ] && keepdir ${GAMES_STATEDIR}/hack && chmod ug+rw ${GAMES_STATEDIR}/hack
	[ `build_game rogue` ] && do_statefile rogue.scores

	# extra docs
	[ `build_game hack` ] && { docinto hack ; dodoc hack/{COPYRIGHT,OWNER,Original_READ_ME,READ_ME,help}; }
	[ `build_game rogue` ] && { docinto rogue ; dodoc rogue/{CHANGES,USD.doc/rogue.me; }

	prepalldocs
	prepgamesdirs
}
