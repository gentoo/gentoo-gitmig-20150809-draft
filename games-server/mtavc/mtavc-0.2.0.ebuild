# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/mtavc/mtavc-0.2.0.ebuild,v 1.4 2004/02/20 07:31:48 mr_bones_ Exp $

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
	insinto ${GAMES_SYSCONFDIR}/${PN}
	local files="banned.lst mtaserver.conf motd.txt"
	doins ${files}
	for f in ${files} ; do
		dosym ${GAMES_SYSCONFDIR}/${PN}/${f} ${dir}/${f}
	done

	dodoc readme.txt
	prepgamesdirs
}
