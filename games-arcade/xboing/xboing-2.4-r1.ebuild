# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xboing/xboing-2.4-r1.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="blockout type game where you bounce a proton ball trying to destroy blocks"
HOMEPAGE="http://www.techrescue.org/xboing/"
SRC_URI="http://www.techrescue.org/xboing/${PN}${PV}.tar.gz
	mirror://gentoo/xboing-${PV}-debian.patch.bz2"

LICENSE="xboing"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/xboing-${PV}-debian.patch
}

src_compile() {
	xmkmf -a || die
	cp Imakefile{,.orig}
	sed -e "s:GENTOO_VER:${PF/${PN}-/}:" \
		Imakefile.orig > Imakefile
	emake \
		CXXOPTIONS="${CXXFLAGS}" \
		CDEBUGFLAGS="${CFLAGS}" \
		XBOING_DIR=${GAMES_DATADIR}/${PN} \
		|| die
}

src_install() {
	make \
		PREFIX=${D} \
		XBOING_DIR=${GAMES_DATADIR}/${PN} \
		install \
		|| die
	fperms 660 ${GAMES_STATEDIR}/xboing.score
	newman xboing.man xboing.6
	dodoc README docs/*.doc
	prepgamesdirs
}
