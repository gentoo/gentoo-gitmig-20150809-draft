# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xboing/xboing-2.4-r2.ebuild,v 1.1 2006/03/14 19:22:42 tupone Exp $

inherit eutils games

DESCRIPTION="blockout type game where you bounce a proton ball trying to destroy blocks"
HOMEPAGE="http://www.techrescue.org/xboing/"
SRC_URI="http://www.techrescue.org/xboing/${PN}${PV}.tar.gz
	mirror://gentoo/xboing-${PV}-debian.patch.bz2"

LICENSE="xboing"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

RDEPEND="|| ( x11-libs/libXpm virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( app-text/rman
			x11-misc/gccmakedep
			x11-misc/imake )
		virtual/x11 )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/01_all_insaneSpeed.patch \
		"${WORKDIR}"/xboing-${PV}-debian.patch
	sed -i '/^#include/s:xpm\.h:X11/xpm.h:' *.c
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
