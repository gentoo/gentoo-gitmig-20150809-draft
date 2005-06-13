# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/industri/industri-1.01.ebuild,v 1.8 2005/06/13 00:39:18 vapier Exp $

inherit games toolchain-funcs

DESCRIPTION="Quake/Tenebrae based, single player game"
HOMEPAGE="http://industri.sourceforge.net/"
SRC_URI="mirror://sourceforge/industri/industri_BIN-${PV}-src.tar.gz
	mirror://sourceforge/industri/industri-1.00.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/x11
	media-libs/libpng
	sys-libs/zlib"

S=${WORKDIR}/industri_BIN

src_unpack() {
	unpack ${A}

	cd "${S}"/linux
	mv Makefile.i386linux Makefile
	sed -i "s:-mpentiumpro.*:${CFLAGS} \\\\:" Makefile

	# Remove duplicated typedefs #71841
	cd "${S}"
	for typ in PFNGLFLUSHVERTEXARRAYRANGEAPPLEPROC PFNGLVERTEXARRAYRANGEAPPLEPROC ; do
		if echo '#include <GL/gl.h>' | $(tc-getCC) -E - 2>/dev/null | grep -sq ${typ} ; then
			sed -i \
				-e "/^typedef.*${typ}/d" \
				glquake.h
		fi
	done
}

src_compile() {
	cd linux
	emake MASTER_DIR=${GAMES_DATADIR}/quake-data build_release || die
}

src_install() {
	newgamesbin linux/release*/bin/industri.run industri || die
	dogamesbin "${FILESDIR}"/industri.pretty || die
	insinto /usr/share/icons
	doins industri.ico quake.ico
	dodoc linux/README
	cd "${WORKDIR}"/industri
	dodoc *.txt && rm *.txt
	insinto ${GAMES_DATADIR}/quake-data/industri
	doins *
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Please setup your quake pak files before playing in"
	einfo "${GAMES_DATADIR}/quake-data"
}
