# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.12-r1.ebuild,v 1.3 2004/02/20 06:00:55 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://viceteam.bei.t-online.de/"
SRC_URI="ftp://ftp.funet.fi/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="sdl nls gnome arts"

DEPEND=">=x11-base/xfree-4.0
	sdl? ( media-libs/libsdl )
	gnome? ( gnome-base/libgnomeui )
	arts? ( kde-base/arts )"

src_unpack() {
	unpack ${A}
	if [ `use nls` ] ; then
		cd ${S}/po
		epatch ${FILESDIR}/${PV}-po-Makefile.patch
	else
		cd ${S}
		sed -i '/^SUBDIRS =/s:po::' Makefile.in
	fi
}

src_compile() {
	egamesconf \
		--enable-fullscreen \
		`use_with sdl` \
		`use_with gnome gnomeui` \
		`use_with arts` \
		`use_enable nls` \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die

	dohtml ${D}/usr/lib/vice/doc/*.html
	dodoc \
		${D}/usr/lib/vice/doc/NLS-Howto.txt \
		${D}/usr/lib/vice/doc/Readme.beos \
		${D}/usr/lib/vice/doc/Readme.dos \
		${D}/usr/lib/vice/doc/Win32-Howto.txt \
		${D}/usr/lib/vice/doc/mon.txt

	rm ${D}/usr/lib/vice/doc -rf
}
