# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/uglygs/uglygs-0_rc11.ebuild,v 1.3 2004/02/20 08:08:16 vapier Exp $

inherit games eutils

MY_P=${P/0_/}
DESCRIPTION="quickly searches the network for game servers"
HOMEPAGE="http://uglygs.uglypunk.com/"
SRC_URI="ftp://ftp.uglypunk.com/uglygs/current/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND=">=sys-apps/sed-4"
RDEPEND="net-analyzer/rrdtool
	dev-lang/perl"

S=${WORKDIR}/${MY_P}

UGLY_BASEDIR=${GAMES_LIBDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-uglygs.conf.patch
	sed -i "s:GENTOO_DIR:${UGLY_BASEDIR}:" uglygs.conf
	epatch ${FILESDIR}/${PV}-uglygs.pl.patch
	sed -i "s:GENTOO_DIR:${GAMES_SYSCONFDIR}:" uglygs.pl
}

src_compile() {
	cd qstat
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	insinto ${GAMES_SYSCONFDIR}
	doins uglygs.conf qstat/qstat.cfg

	dogamesbin uglygs.pl || die

	dodir ${UGLY_BASEDIR}
	cp -rf data images templates tmp ${D}/${UGLY_BASEDIR}
	keepdir ${UGLY_BASEDIR}/tmp

	exeinto ${UGLY_BASEDIR}
	doexe qstat/qstat

	dodoc CHANGES INSTALL README

	prepgamesdirs
}

pkg_postinst() {
	einfo "Dont forget to setup ${GAMES_SYSCONFDIR}/uglygs.conf and ${GAMES_SYSCONFDIR}/qstat.cfg"
	games_pkg_postinst
}
