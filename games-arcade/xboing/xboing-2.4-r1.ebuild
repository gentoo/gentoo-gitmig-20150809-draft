# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xboing/xboing-2.4-r1.ebuild,v 1.4 2004/03/02 14:28:23 vapier Exp $

inherit games eutils

DESCRIPTION="blockout type game where you bounce a proton ball trying to destroy blocks"
HOMEPAGE="http://www.techrescue.org/xboing/"
SRC_URI="http://www.techrescue.org/xboing/${PN}${PV}.tar.gz
	mirror://gentoo/xboing-${PV}-debian.patch.bz2"

LICENSE="xboing"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/x11"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/xboing-${PV}-debian.patch
}

src_compile() {
	xmkmf -a || die
	sed -i \
		-e "s:GENTOO_VER:${PF/${PN}-/}:" \
		Imakefile
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
	newman xboing.man xboing.6
	dodoc README docs/*.doc
	prepgamesdirs
	fperms 660 ${GAMES_STATEDIR}/xboing.score
}
