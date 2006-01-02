# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/parsec/parsec-0197.ebuild,v 1.7 2006/01/02 18:52:14 metalgod Exp $

inherit eutils games

DESCRIPTION="Parsec - there is no safe distance"
HOMEPAGE="http://openparsec.sourceforge.net/"
SRC_URI="http://public.www.planetmirror.com/pub/parsec/${PV}/parsec_lan_build${PV}.tar.gz
	ftp://planetmirror.com/pub/parsec/${PV}/parsec_lan_build${PV}.tar.gz
	http://ftp.webmonster.de/pub/parsec/parsec_lan_build${PV}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/openal
	x86? ( sys-libs/lib-compat )
	amd64? ( app-emulation/emul-linux-x86-xlibs
	app-emulation/emul-linux-x86-compat )"

S=${WORKDIR}/${PN}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	cp -r * ${D}/${dir}/
	dogamesbin ${FILESDIR}/parsec
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/parsec
	prepgamesdirs
}
