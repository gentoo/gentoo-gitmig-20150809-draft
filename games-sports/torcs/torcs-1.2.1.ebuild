# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/torcs/torcs-1.2.1.ebuild,v 1.1 2003/09/11 12:26:35 vapier Exp $

inherit games

DESCRIPTION="The Open Racing Car Simulator"
HOMEPAGE="http://torcs.org/"
SRC_URI="mirror://sourceforge/torcs/TORCS-${PV}-src.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-tracks-base.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-extra.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-Patwo-Design.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-src-robots-base.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-libs/plib-1.6
	>=sys-apps/sed-4
	virtual/opengl
	virtual/glut
	media-libs/libpng
	sys-libs/zlib"

src_compile() {
	sed -i "/^instdir =/s:=.*:= ${GAMES_DATADIR}/${PN}:" Make-config.in
	egamesconf \
		--libdir=${GAMES_LIBDIR}/${PN} \
		|| die
	env HOME=${T} make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dosed "s:DEFAULT_RUNTIME=.*:DEFAULT_RUNTIME=${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/torcs
	mv ${WORKDIR}/{cars,categories,data,menu,tracks} ${D}/${GAMES_DATADIR}/${PN}/
	dodoc README.linux
	dohtml *.html *.png
	prepgamesdirs
}
