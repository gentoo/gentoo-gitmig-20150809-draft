# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/chromium/chromium-0.9.12-r4.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games eutils

S=${WORKDIR}/Chromium-0.9
DESCRIPTION="Chromium B.S.U. - an arcade game"
HOMEPAGE="http://www.reptilelabour.com/software/chromium/"
SRC_URI="http://www.reptilelabour.com/software/files/chromium/chromium-src-${PV}.tar.gz
	 http://www.reptilelabour.com/software/files/chromium/chromium-data-${PV}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="Artistic"
IUSE="arts esd qt sdl svga oggvorbis alsa"

DEPEND="virtual/glibc
	sys-devel/gcc
	virtual/glut
	sdl? ( media-libs/libsdl )
	qt? ( =x11-libs/qt-2* )
	oggvorbis? ( media-libs/libogg media-libs/libvorbis )
	media-libs/libggi
	media-libs/libgii
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/kdelibs )
	esd? ( media-sound/esound )
	media-libs/audiofile
	svga? ( media-libs/svgalib )
	>=media-libs/smpeg-0.4.4-r1" # this last isn't strictly needed but is useful

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc3-gentoo.patch
}

src_compile() {
	local myconf
	myconf="${myconf} --enable-smpeg"
	myconf="${myconf} `use_enable sdl`"
	myconf="${myconf} `use_enable oggvorbis vorbis`"
	myconf="${myconf} `use_enable qt setup`"

	./configure ${myconf} || die
	QTDIR=/usr/qt/2 make || die
}

src_install() {
	rm -rf `find -name CVS`

	exeinto ${GAMES_BINDIR}
	doexe bin/chromium*

	dodir ${GAMES_DATADIR}/${PN}
	cp -a data/* ${D}/${GAMES_DATADIR}/${PN}/

	dodir /etc/env.d
	echo "CHROMIUM_DATA=${GAMES_DATADIR}/${PN}" > ${D}/etc/env.d/99chromium

	prepgamesdirs
}
