# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/bsd-games/bsd-games-2.13.ebuild,v 1.4 2004/01/08 02:44:18 avenj Exp $

inherit games eutils

DESCRIPTION="collection of games from NetBSD"
HOMEPAGE="http://www.advogato.org/proj/bsd-games/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/games/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc amd64"

DEPEND="sys-libs/ncurses
	sys-apps/miscfiles
	sys-apps/less
	sys-devel/bison
	sys-devel/flex
	>=sys-apps/sed-4"

# Set GAMES_TO_BUILD variable to whatever you want
export GAMES_TO_BUILD=${GAMES_TO_BUILD:="adventure arithmetic atc
backgammon banner battlestar bcd boggle caesar canfield cribbage fish
gomoku hangman hunt mille monop morse number phantasia pig pom ppt
primes quiz rain random robots sail snake tetris trek wargames worm
worms wtf wump"}

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/bsdgames_${PV}-11.diff
	epatch ${FILESDIR}/bsdgames-${PV}-gentoo.diff

	sed -i \
		-e "s:/usr/games:${GAMES_BINDIR}:" wargames/wargames \
		|| die "sed wargames failed"

	cp ${FILESDIR}/config.params-gentoo config.params
	echo bsd_games_cfg_build_dirs=\"${GAMES_TO_BUILD}\" >> ./config.params
}

src_compile() {
	./configure || die
	emake OPTIMIZE="${CFLAGS}" || die "emake failed"
}

build_game() { has ${1} ${GAMES_TO_BUILD}; }
do_statefile() {
	touch ${D}/${GAMES_STATEDIR}/${1}
	chmod ug+rw ${D}/${GAMES_STATEDIR}/${1}
}
src_install() {
	dodir ${GAMES_BINDIR} ${GAMES_STATEDIR} /usr/share/man/man{1,6}
	make DESTDIR=${D} install-strip || die

	dodoc AUTHORS BUGS COPYING ChangeLog ChangeLog.0 INSTALL \
		README PACKAGING SECURITY THANKS TODO YEAR2000

	# special subdirs
	#[ `build_game atc` ] && dodir ${GAMES_DATADIR}/atc
	#[ `build_game boggle` ] && dodir ${GAMES_DATADIR}/boggle
	#[ `build_game quiz` ] && dodir ${GAMES_DATADIR}/quiz

	# set some binaries to run as games group (+S)
	[ `build_game atc` ] && fperms g+s ${GAMES_BINDIR}/atc
	[ `build_game battlestar` ] && fperms g+s ${GAMES_BINDIR}/battlestar
	[ `build_game canfield` ] && fperms g+s ${GAMES_BINDIR}/canfield
	[ `build_game cribbage` ] && fperms g+s ${GAMES_BINDIR}/cribbage
	[ `build_game phantasia` ] && fperms g+s ${GAMES_BINDIR}/phantasia
	[ `build_game robots` ] && fperms g+s ${GAMES_BINDIR}/robots
	[ `build_game sail` ] && fperms g+s ${GAMES_BINDIR}/sail
	[ `build_game snake` ] && fperms g+s ${GAMES_BINDIR}/snake
	[ `build_game tetris` ] && fperms g+s ${GAMES_BINDIR}/tetris-bsd

	# state files
	[ `build_game atc` ] && do_statefile atc_score
	[ `build_game battlestar` ] && do_statefile battlestar.log
	[ `build_game canfield` ] && do_statefile cfscores
	[ `build_game cribbage` ] && do_statefile criblog
	[ `build_game robots` ] && do_statefile robots_roll
	[ `build_game sail` ] && do_statefile saillog
	[ `build_game snake` ] && do_statefile snake.log && do_statefile snakerawscores
	[ `build_game tetris` ] && do_statefile tetris-bsd.scores
	# state dirs
	#[ `build_game phantasia` ] && dodir ${GAMES_STATEDIR}/phantasia
	#[ `build_game sail` ] && dodir ${GAMES_STATEDIR}/sail
	chmod -R ug+rw ${D}/${GAMES_STATEDIR}/*

	# extra docs
	[ `build_game atc` ] && { docinto atc ; dodoc atc/BUGS; }
	[ `build_game boggle` ] && { docinto boggle ; dodoc boggle/README{,.linux}; }
	[ `build_game hunt` ] && { docinto hunt ; dodoc hunt/README{,.linux}; }
	[ `build_game phantasia` ] && { docinto phantasia ; dodoc phantasia/{OWNER,README}; }
	[ `build_game trek` ] && { docinto trek ; dodoc trek/USD.doc/trek.me; }

	# Since factor is usually not installed, and primes.6 is a symlink to
	# factor.6, make sure that primes.6 is ok ...
	if [ `build_game primes` ] && [ ! `build_game factor` ] ; then
		rm -f ${D}/usr/share/man/man6/{factor,primes}.6
		newman factor/factor.6 primes.6
	fi

	prepalldocs
	prepgamesdirs
}
