# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.14.ebuild,v 1.2 2004/02/20 06:00:55 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://www.viceteam.org/"
SRC_URI="ftp://ftp.funet.fi/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="sdl nls gnome arts"

RDEPEND="virtual/x11
	sdl? ( media-libs/libsdl )
	gnome? ( gnome-base/libgnomeui )
	arts? ( kde-base/arts )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	use nls && epatch ${FILESDIR}/${PV}-po-Makefile.patch
}

src_compile() {
	egamesconf \
		--enable-fullscreen \
		--disable-dependency-tracking \
		`use_with sdl` \
		`use_with gnome gnomeui` \
		`use_with arts` \
		`use_enable nls` \
		|| die
	emake || die "emake failed"
}

src_install() {
	local docdir="${D}${GAMES_LIBDIR}/${PN}/doc"
	make DESTDIR=${D} install || die "make install failed"
	dohtml ${docdir}/* || die "dohtml failed"
	dodoc \
		AUTHORS ChangeLog FEEDBACK README \
		${docdir}/{BUGS,NEWS,PETdoc.txt,TODO} \
		${docdir}/{cbm_basic_tokens.txt,drive_info.txt,mon.txt,serial.txt}
	rm -rf ${docdir}
	prepgamesdirs
}
