# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/openmsx/openmsx-0.3.3.ebuild,v 1.3 2004/01/27 23:39:22 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="MSX emulator that aims for perfection"
HOMEPAGE="http://openmsx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

# fix bug 32745
replace-flags '-Os' '-O2'

DEPEND="dev-libs/libxml2
	media-libs/libpng
	sys-libs/zlib
	media-libs/sdl-image
	media-libs/libsdl
	virtual/x11
	virtual/opengl"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# Remove all symlinking from the Makefile.in
	sed -i \
		-e "/ln /d" Makefile.in || \
			die "sed Makefile.in failed"

	# Change the hardcoded default SystemDir.
	sed -i \
		-e "s:/opt/openMSX/:${GAMES_DATADIR}/${PN}/:" \
			src/file/FileOperations.cc || \
				die "sed FileOperations.cc failed"
}

src_install() {
	egamesinstall prefix="${D}${GAMES_DATADIR}/${PN}" \
		bindir=${D}${GAMES_BINDIR} || die

	dosym ${GAMES_DATADIR}/${PN}/share/machines/National_CF-1200 \
		  ${GAMES_DATADIR}/${PN}/share/machines/msx1
	dosym ${GAMES_DATADIR}/${PN}/share/machines/Philips_NMS_8250 \
		  ${GAMES_DATADIR}/${PN}/share/machines/msx2
	dosym ${GAMES_DATADIR}/${PN}/share/machines/Panasonic_FS-A1FX \
		  ${GAMES_DATADIR}/${PN}/share/machines/msx2plus
	dosym ${GAMES_DATADIR}/${PN}/share/machines/Panasonic_FS-A1GT \
		  ${GAMES_DATADIR}/${PN}/share/machines/turbor

	dodoc README AUTHORS NEWS ${D}${GAMES_DATADIR}/openmsx/*.{txt,tex} || \
		die "dodoc failed"
	dohtml -r doc/* || die "dohtml failed"

	# Tidy up install
	rm -f ${D}${GAMES_DATADIR}/openmsx/*.{txt,tex,html,png,css}
	find ${D}${GAMES_DATADIR} -type f -exec chmod a-x \{\} \;

	prepgamesdirs
}
