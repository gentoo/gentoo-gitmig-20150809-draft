# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout2/lbreakout2-2.5_beta3.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit flag-o-matic games

MY_P=${PN}-2.5beta-3
DESCRIPTION="Breakout clone written with the SDL library"
HOMEPAGE="http://lgames.sourceforge.net/"
SRC_URI="mirror://sourceforge/lgames/${MY_P}.tar.gz"
levels="Afl Arcade BeOS-4ever Bombs Chaos Demons HereWeGo HighBall Holidays Hommage Kazan-1 Kevin Lattsville LinuxFun Megadoomer OpenSource Pabelo Ph33r R-World Runes Shimitar TheGauntlet Twilight Wolvie ZijosLand Zufallswelt"
for x in ${levels} ; do
	SRC_URI="$SRC_URI
	http://lgames.sourceforge.net/LBreakout2/levels/${x}"
done

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc
	>=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	for x in ${levels}; do
		cp ${DISTDIR}/${x} ${S}
	done
}

src_compile() {
	filter-flags -O?
	egamesconf \
		--with-doc-path=/usr/share/doc/${PF} \
		--datadir=${GAMES_DATADIR_BASE} \
		|| die
	make || die "make failed"
}

src_install() {
	dodir ${GAMES_STATEDIR}
	egamesinstall \
		inst_dir=${D}/${GAMES_DATADIR}/${PN} \
		hi_dir=${D}/${GAMES_STATEDIR}/ \
		doc_dir=${D}/usr/share/doc/${PF} \
			|| die

	insinto ${GAMES_DATADIR}/lbreakout2/levels
	doins ${levels}

	dodoc AUTHORS README TODO ChangeLog
	mv ${D}/usr/share/doc/${PF}/lbreakout2 ${D}/usr/share/doc/${PF}/html
	prepgamesdirs
}
