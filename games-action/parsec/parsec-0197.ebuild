# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/parsec/parsec-0197.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

DESCRIPTION="Parsec - there is no safe distance"
HOMEPAGE="http://openparsec.sourceforge.net/"
SRC_URI="http://public.www.planetmirror.com/pub/parsec/${PV}/parsec_lan_build${PV}.tar.gz
	ftp://planetmirror.com/pub/parsec/${PV}/parsec_lan_build${PV}.tar.gz
	http://ftp.webmonster.de/pub/parsec/parsec_lan_build${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/openal"

S=${WORKDIR}/${PN}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	cp -r * ${D}/${dir}/
	dogamesbin ${FILESDIR}/parsec
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/parsec
	prepgamesdirs
}
