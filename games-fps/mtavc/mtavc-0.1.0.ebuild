# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/mtavc/mtavc-0.1.0.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games

S=${WORKDIR}
DESCRIPTION="A server for a multi-player mod for GTA3"
HOMEPAGE="http://www.multitheftauto.com/"
SRC_URI="MTAServer-${PV}-tar.gz"

RESTRICT="fetch"
LICENSE="as-is"
KEYWORDS="-* x86"
IUSE=""
SLOT="0"

DEPEND="virtual/glibc
	sys-libs/lib-compat"

pkg_nofetch() {
	einfo
	einfo
	einfo "Please download ${A} from "
	einfo "${HOMEPAGE} and put it in ${DISTDIR}"
	einfo
	einfo
}

src_unpack() {
	tar -zxf ${DISTDIR}/${A}
}

src_install() {
	dogamesbin ${FILESDIR}/mtavc
	exeinto /opt/mtavc
	doexe MTAServer
	insinto /opt/mtavc
	doins banned.lst mtaserver.conf
	dodoc readme.txt
	prepgamesdirs
}
