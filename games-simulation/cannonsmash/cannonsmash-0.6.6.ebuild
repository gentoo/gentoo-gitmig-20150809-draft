# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/cannonsmash/cannonsmash-0.6.6.ebuild,v 1.2 2004/03/27 11:28:30 dholm Exp $

inherit games

MY_OGG=danslatristesse2-48.ogg
DESCRIPTION="3D tabletennis game"
HOMEPAGE="http://cannonsmash.sourceforge.net/"
SRC_URI="mirror://sourceforge/cannonsmash/csmash-${PV}.tar.gz
	oggvorbis? ( http://nan.p.utmc.or.jp/${MY_OGG} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="oggvorbis nls"

RDEPEND="virtual/glibc
	virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.3
	>=media-libs/sdl-image-1.2.2
	=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	oggvorbis? ( >=sys-apps/sed-4 )"

S="${WORKDIR}/csmash-${PV}"

src_unpack() {
	unpack csmash-${PV}.tar.gz
	cd ${S}
	if use oggvorbis ; then
		cp ${DISTDIR}/${MY_OGG} ${S}/ || die "cp failed"
		sed -i \
			-e "s:${MY_OGG}:${GAMES_DATADIR}/csmash/${MY_OGG}:" ttinc.h \
				|| die "setting ogg loc"
	fi
}

src_compile() {
	egamesconf \
		`use_enable nls` \
		--datadir="${GAMES_DATADIR_BASE}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	egamesinstall \
		datadir="${D}/${GAMES_DATADIR_BASE}" \
		|| die
	if use oggvorbis ; then
		insinto "${GAMES_DATADIR}/csmash"
		doins "${MY_OGG}"
	fi
	dodoc AUTHORS CREDITS README*
	prepgamesdirs
}
