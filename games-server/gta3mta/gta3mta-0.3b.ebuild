# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/gta3mta/gta3mta-0.3b.ebuild,v 1.2 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="dedicated server for GTA3 multiplayer"
HOMEPAGE="http://mtavc.com/"
SRC_URI="dedlinux.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="fetch"

DEPEND="virtual/glibc
	sys-libs/lib-compat"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "${HOMEPAGE}downloads.php?file_id=12"
	einfo "and put it in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	edos2unix server.cfg
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	dogamesbin ${FILESDIR}/gta3mta
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/gta3mta

	exeinto ${dir}
	doexe MTAServer
	insinto ${GAMES_SYSCONFDIR}/${PN}
	local files="banned.lst server.cfg"
	doins ${files}
	for f in ${files} ; do
		dosym ${GAMES_SYSCONFDIR}/${PN}/${f} ${dir}/${f}
	done

	prepgamesdirs
}
