# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/nwn-ded/nwn-ded-1.61.ebuild,v 1.1 2004/01/29 08:53:40 vapier Exp $

inherit games

DESCRIPTION="Neverwinter Nights Dedicated server"
HOMEPAGE="http://nwn.bioware.com/downloads/standaloneserver.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/standaloneserver/NWNDedicatedServer${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="nomirror"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	tar -zxf linuxdedserver${PV/.}.tar.gz || die
	rm linuxdedserver${PV/.}.tar.gz
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	mv ${S}/* ${D}/${dir}/ || die "installing server"
	dogamesbin ${FILESDIR}/nwserver
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/nwserver

	prepgamesdirs
	chmod -R g+w ${D}/${dir}
}
