# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/mtavc/mtavc-0.2.0.ebuild,v 1.2 2003/09/21 04:36:41 vapier Exp $

inherit games eutils

S=${WORKDIR}
DESCRIPTION="A server for a multi-player mod for GTA3: Vice City"
HOMEPAGE="http://mtavc.com/"
SRC_URI="MTAServer-Linux-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="fetch"

DEPEND="virtual/glibc
	sys-libs/lib-compat"

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "${HOMEPAGE}downloads.php?file_id=33"
	einfo "and put it in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	edos2unix mtaserver.conf
	sed -i 's:NoName:Gentoo:' mtaserver.conf
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	dogamesbin ${FILESDIR}/mtavc
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/mtavc

	exeinto ${dir}
	doexe MTAServer
	insinto ${dir}
	doins banned.lst mtaserver.conf motd.txt
	insinto ${GAMES_SYSCONFDIR}
	doins mtaserver.conf
	dosym ${GAMES_SYSCONFDIR}/mtaserver.conf ${dir}/mtaserver.conf

	dodoc readme.txt
	prepgamesdirs
}
