# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/game-launcher/game-launcher-0.9.8.ebuild,v 1.4 2003/06/21 08:05:27 vapier Exp $

inherit games eutils

DESCRIPTION="universal front end for emulators ... works with MAME, Nesticle, RockNES, zSNES, snes9x, Callus, Stella, z26, and Genecyst"
HOMEPAGE="http://www.dribin.org/dave/game_launcher/"
SRC_URI="mirror://sourceforge/glaunch/gl${PV//./}s.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=media-libs/allegro-4.0.0
	>=media-libs/loadpng-0.11
	>=media-libs/allegromp3-2.0.2
	>=media-libs/allegttf-2.0
	>=media-libs/libpng-1.2.4
	>=media-libs/jpgalleg-1.1
	>=sys-libs/zlib-1.1.4"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/glaunch

src_compile() {
	edos2unix `find -regex '.*\.[ch]' -or -name '*.cc'`

	epatch ${FILESDIR}/${PV}-gcc3.patch
	epatch ${FILESDIR}/${PV}-digi-oss.patch

	mv common.mk common.mk_orig
	sed s/'TARGET\(.*\)= MINGW'/'#TARGET\1= MINGW'/ common.mk_orig | sed s/'#TARGET\(.*\)= UNIX'/'TARGET\1= UNIX'/ > common.mk
	emake || die
}

src_install() {
	dodir /opt/${P}
	cp -r ${S}/* ${D}/opt/${P}  # doinst can't do recursive
	prepgamesdirs
}
