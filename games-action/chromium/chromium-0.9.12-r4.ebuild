# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/chromium/chromium-0.9.12-r4.ebuild,v 1.4 2003/11/16 01:18:38 vapier Exp $

inherit games eutils

DESCRIPTION="Chromium B.S.U. - an arcade game"
HOMEPAGE="http://www.reptilelabour.com/software/chromium/"
SRC_URI="http://www.reptilelabour.com/software/files/chromium/chromium-src-${PV}.tar.gz
	 http://www.reptilelabour.com/software/files/chromium/chromium-data-${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc alpha amd64"
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

S=${WORKDIR}/Chromium-0.9

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
	find ${D} -name CVS -type d -exec rm -rf '{}' \;

	exeinto ${GAMES_BINDIR}
	doexe bin/chromium*

	dodir ${GAMES_DATADIR}/${PN}
	cp -a data/* ${D}/${GAMES_DATADIR}/${PN}/

	dodir /etc/env.d
	echo "CHROMIUM_DATA=${GAMES_DATADIR}/${PN}" > ${D}/etc/env.d/99chromium

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "Before you play this game you must"
	ewarn "update your environment."
	ewarn "Either restart your shell or just run:"
	ewarn "source /etc/profile"
}
