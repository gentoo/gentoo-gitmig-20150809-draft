# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/torcs/torcs-1.2.2.ebuild,v 1.3 2004/02/27 19:30:01 vapier Exp $

inherit games

DESCRIPTION="The Open Racing Car Simulator"
HOMEPAGE="http://torcs.org/"
SRC_URI="mirror://sourceforge/torcs/TORCS-${PV}-src.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-tracks-road.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-tracks-dirt.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-src-robots-base.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-extra.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-nascar.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-src-robots-K1999.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-src-robots-astigot.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-src-robots-berniw.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-src-robots-billy.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-src-robots-bt.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-Patwo-Design.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-kcendra-gt.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-kcendra-roadsters.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-kcendra-sport.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-cars-VM.tgz
	mirror://sourceforge/torcs/TORCS-${PV}-data-tracks-oval.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=media-libs/plib-1.6
	virtual/opengl
	virtual/glut
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

HOME="${T}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^datadir =/s:=.*:= ${GAMES_DATADIR}/${PN}:" \
		Make-config.in \
		|| die "sed Make-config.in failed"
}

src_compile() {
	egamesconf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dosed "s:DATADIR=.*:DATADIR=${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/torcs
	cp -r ${WORKDIR}/{cars,categories,data,menu,tracks} \
		"${D}/${GAMES_DATADIR}/${PN}/" \
		|| die "cp failed"
	dodoc README.linux
	dohtml *.html *.png
	prepgamesdirs
}
