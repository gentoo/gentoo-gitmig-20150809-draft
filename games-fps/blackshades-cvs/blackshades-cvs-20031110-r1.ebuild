# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/blackshades-cvs/blackshades-cvs-20031110-r1.ebuild,v 1.3 2006/12/06 20:18:12 wolf31o2 Exp $

#ECVS_PASS="anonymous"
#ECVS_SERVER="icculus.org:/cvs/cvsroot"
ECVS_MODULE="blackshades"
#inherit cvs
inherit eutils games

DESCRIPTION="you control a psychic bodyguard, and try to protect the VIP"
HOMEPAGE="http://www.wolfire.com/blackshades.html http://www.icculus.org/blackshades/"
SRC_URI="http://filesingularity.timedoctor.org/Textures.tar.bz2
	mirror://gentoo/blackshades-${PV}.tar.bz2"

LICENSE="blackshades"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libvorbis
	media-libs/openal
	media-libs/freealut
	media-libs/libsdl"

S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	if [ -z "${ECVS_SERVER}" ] ; then
		unpack blackshades-${PV}.tar.bz2
	else
		cvs_src_unpack
	fi
	cd "${WORKDIR}"
	unpack Textures.tar.bz2
	cd "${S}"
	rm -rf Data/Textures
	mv "${WORKDIR}"/Textures Data/ || die "mv failed"
	sed -i \
		-e "/^CFLAGS/s:$: ${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
	find "${S}" -type d -name CVS -exec rm -rf \{\} \; 2> /dev/null
	find "${S}/Data/Textures" -type f -name ".*" -exec rm -f \{\} \;
	find "${S}/Data/" -type f -exec chmod a-x \{\} \;
	# Glut is not really needed, but there is an include in the source
	# We patch it
	sed -i \
		-e "/glut.h/d" Source/Decals.h \
		|| die "removing glut include failed"
	epatch "${FILESDIR}"/${PN}-freealut.patch
}

src_install() {
	games_make_wrapper blackshades blackshades-bin "${GAMES_DATADIR}/${PN}"
	newgamesbin objs/blackshades blackshades-bin || die "newgamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r Data/ || die "doins failed"

	dodoc IF_THIS_IS_A_README_YOU_HAVE_WON Readme TODO uDevGame_Readme
	make_desktop_entry blackshades "Black Shades"
	prepgamesdirs
}
